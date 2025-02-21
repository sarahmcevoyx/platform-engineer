pipeline {
    agent {
        label 'terraform-kitchen-agent'
    }

    environment {
        ARM_CLIENT_ID       = credentials('azure-client-id')
        ARM_CLIENT_SECRET   = credentials('azure-client-secret')
        ARM_SUBSCRIPTION_ID = credentials('azure-subscription-id')
        ARM_TENANT_ID       = credentials('azure-tenant-id')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Bundler') {
            steps {
                script {
                    sh 'gem install bundler'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'bundle install'
                }
            }
        }

        stage('TruffleHog Scan') {
            steps {
                script {
                    sh 'trufflehog filesystem .'
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('TruffleHog scan failed')
                    }
                }
            }
        }

        stage('Aqua Scan') {
            steps {
                script {
                    sh 'aqua scan --local .'
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('Aqua scan failed')
                    }
                }
            }
        }

        stage('Test Kitchen Setup') {
            steps {
                script {
                    sh 'bundle exec kitchen create'
                    sh 'bundle exec kitchen converge'
                }
            }
        }

        stage('Test Kitchen Verify') {
            steps {
                script {
                    sh 'bundle exec kitchen verify'
                }
            }
        }

        stage('Test Kitchen Destroy') {
            steps {
                script {
                    sh 'bundle exec kitchen destroy'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    dir('envs/TST') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    dir('envs/TST') {
                        sh 'terraform plan -var-file=variables.tf -out=tfplan'
                    }
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('Terraform plan failed')
                    }
                }
            }
        }

        stage('Run InSpec Check') {
            steps {
                script {
                    sh 'git clone https://<teams-repo-url>/inspec-check.git'
                    dir('inspec-check') {
                        sh 'bundle exec inspec exec . --reporter=json'
                    }
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('InSpec check failed')
                    }
                }
            }
        }

        stage('Wait for PR Approval') {
            steps {
                script {
                    timeout(time: 3, unit: 'DAYS') {
                        input message: 'Has the PR been approved?'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    dir('envs/TST') {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('Terraform apply failed')
                    }
                }
            }
        }

        stage('Install Azure CLI & Function Tools') {
            steps {
                script {
                    sh 'curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash'
                    sh 'npm install -g azure-functions-core-tools@4 --unsafe-perm true'
                }
            }
        }

        stage('Install Function Dependencies') {
            steps {
                script {
                    sh '''
                    find functions -maxdepth 1 -type d ! -path functions -exec sh -c '
                        for dir; do
                            cd "$dir"
                            pip install -r requirements.txt
                            cd - >/dev/null
                        done
                    ' sh {} +
                    '''
                }
            }
        }

        stage('Lint & Test Functions') {
            steps {
                script {
                    sh '''
                    find functions -maxdepth 1 -type d ! -path functions -exec sh -c '
                        for dir; do
                            cd "$dir"
                            flake8 . --exclude=venv
                            pytest --disable-warnings
                            cd - >/dev/null
                        done
                    ' sh {} +
                    '''
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('Function linting or tests failed! Aborting deployment.')
                    }
                }
            }
        }

        stage('Deploy Azure Functions') {
            steps {
                script {
                    sh '''
                    find functions -maxdepth 1 -type d ! -path functions -exec sh -c '
                        for dir; do
                            cd "$dir"
                            withCredentials([string(credentialsId: 'azure-function-app-name', variable: 'AZURE_FUNCTION_APP_NAME')]) {
                                sh 'func azure functionapp publish ${AZURE_FUNCTION_APP_NAME}'
                            }
                            cd - >/dev/null
                        done
                    ' sh {} +
                    '''
                }
            }
        }

        stage('Run End-to-End Tests') {
            steps {
                script {
                    // Define function app hostnames and endpoints
                    def functionHostnames = [
                        'productDenormalisation': 'https://<YOUR_FUNCTION_APP_NAME>.azurewebsites.net/api/productDenormalisation'
                    ]
                    functionHostnames.each { functionName, url ->
                        // Perform HTTP GET and POST requests to test the function endpoints
                        sh """
                        echo "Testing ${functionName} at ${url}"
                        http --check-status GET ${url} > /dev/null
                        http --check-status POST ${url} productId=1 name=ProductA category=CategoryA > /dev/null
                        """
                    }
                }
            }
            post {
                failure {
                    script {
                        currentBuild.result = 'FAILURE'
                        error('End-to-End tests failed! Aborting deployment.')
                    }
                }
            }
        }

        stage('Update Changelog') {
            steps {
                script {
                    sh './scripts/update_changelog.sh'
                }
            }
            post {
                success {
                    script {
                        sh 'git push origin HEAD:refs/heads/main'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            script {
                def failedStage = currentBuild.rawBuild.getLog(100).find { it contains('[Pipeline]') && it contains('End of Pipeline') }
                echo "Pipeline failed at stage: ${failedStage ? failedStage.split(' ')[2] : 'Unknown'}"
            }
        }
    }
}
