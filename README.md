# platform-engineer assessment 

***Important Note:***
***due to not being able to gain access to the Azure platform, this implementation is based on theoretical knowledge and what I would put into practice. While some details may not reflect my exact implementation approach, the overall strategy remains consistent with my planned solutions. Further explanation will be provided within this readme and when I speak about it.***



### CODEOWNERS:
I have included a GitHub folder containing the CODEOWNERS file. This file defines specific read and write privileges for designated teams. To safeguard the code from unauthorised changes, teams without the necessity for editing will have their write permissions restricted. Additionally, more sensitive files, such as the Jenkinsfile and those within the modules folder, will require a higher level of approval (@authorised_team)..



### CHANGELOG.md
A CHANGELOG.md file is crucial for maintaining transparency, as it provides a clear record of all changes made to the project. It facilitates effective communication among team members and users by documenting new features, bug fixes, and updates. Additionally, it supports version control and accountability, ensuring that modifications are easily traceable and manageable.



### versions.tf:
Having the versions.tf file in both my root directory and modules directory ensures that the entire config, including all modules, uses consistent versions of Terraform and its providers. Specifying versions helps avoid unexpected changes due to provider updates, ensuring that infrastructure remains stable, predictable, and maintainable.



### outputs.tf:
An outputs.tf file is essential for providing visibility into the values of created resources, facilitating the integration and automation of infrastructure. Including this file in both the root directory and modules ensures modularity and centralisation, enabling seamless information sharing and management across the entire Terraform config.



### scripts:
I have integrated a script into the Jenkins pipeline to automate updates to the CHANGELOG.md file. This ensures that the changelog remains accurate and up-to-date.

***note: other scripts can be added here, such as a hook.py/hook.tf.*** 

***hook.tf - defines how to use the hook.py script to manage and execute plugin.s***

***hook.py - script that handles the loading and execution of specific methods from plugins stored in a Git repo. Ensures only one instance of the script runs atr a time to avoid conflicts.***



### Gemfile:
By specifying the Ruby version and sourcing the necessary gem in my config file, along with automating the installation of Bundler and the project's dependencies in my Jenkinsfile, I enable the pipeline to run kitchen-terraform.

***note: nexus is my choice of repo manager as that is what I currently use.***



### env:
I have added an env folder with empty TST, BLD, and PRD subfolders as placeholders. Ideally, this repo should serve as a Terraform module to define the config, while a separate repo should handle the deployment of the Windows platform app. However, for the purpose of this assessment, these subfolders demonstrate that individual config can be added for each respective environment, facilitating specific deployments.



### Jenkinsfile:
The purpose of the Jenkinsfile is to define a pipeline that automates the build, test, and deployment processes for my project. It ensures consistency and reliability by specifying stages for tasks such as installing dependencies, running tests, and deploying applications. This automation streamlines workflows, reduces manual intervention, and enhances the overall efficiency of the development lifecycle.

***note: to configure Jenkins, I would deploy 2 AKS clusters and install Jenkins using a Kubernetes manifest file. These clusters will be strategically located in different regions to ensure high availability and redundancy. In the event of a regional failure, Jenkins will automatically failover to the other region, ensuring continuous operation with no downtime.***

***Ideally, there would be a project resources repo dedicated to creating resources, such as clusters, where I would maintain my Terraform config (terraform.tfvars) and Helm charts (charts.yaml).***



### root main.tf:
vnet / subnet - sets up a secure and isolated network environment in Azure by defining a VNet and a subnet within it. This setup allows for efficient network segmentation and control, facilitating secure communication between resources within the VNet and enabling integration with Azure services through service endpoints.

functions_kv - config ensures that the Key Vault is securely deployed and managed, with strict access controls and network rules in place to protect sensitive cryptographic keys and secrets. Configures network access control lists to enhance the security of the Key Vault by restricting access based on network rules.

***I acknowledge that the implementation in Azure differs to GCP, and given the limited time I've spent working on this, I understand that my current config might not be entirely structurally correct (definitely isn't). However, my primary objective is to allow each FA to utilise either keys or secrets based on its specific requirements. This repo is intended to serve as a Terraform module for multiple FAs, each with unique use cases and permission needs. By opting for both keys and secrets, I can ensure that the appropriate permissions are granted according to the specific needs of each FA, thus achieving flexibility and secure access management.***

example_key - by setting up this cryptographic key within an Azure Key Vault, it ensure that sensitive cryptographic operations are performed securely and efficiently, set to least priviledged principle


***note: ideally, a separate repo should be maintained for creating and managing keys. This specific config would then be responsible for referencing and defining the specific key to be used.***


azurerm_log_analytics_workspace - by configuring an Azure Log Analytics Workspace, I can effectively monitor and analyse the health and performance of my Azure infrastructure, ensuring efficient operations and preventive management.

azurerm_monitor_diagnostic_setting - by configuring diagnostic settings, it ensures that Azure Key Vault's operational and security data is systematically collected, monitored, and retained, enabling proactive management and compliance.

azurerm_monitor_metric_alert - by configuring a metric alert, it ensures that I am promptly notified of any significant changes in the health and performance of Azure Key Vault, allowing for effective management and resolution of potential issues.



### modules:
The modules folder contains reusable, self-contained Terraform configs. Each module within this folder is designed to manage specific infrastructure components or services. By organising Terraform code into modules, this promotes modularity and maintainability, allowing for easier management, updates, and reuse across different projects or environments. This structure also enhances the scalability and consistency of IaC practices.

Within the modules folder, I have created a functions folder dedicated to the creation of new functions. Inside it, there is a test folder that currently contains a simple unit test. This folder is intended to also accommodate integration tests for subsequent functions. Thoroughly testing these functions before deployment is crucial to ensure their functionality and prevent the deployment of faulty FAs.

***note: Ideally, these tests should be written in a Jenkins shared library (seperate repo) and said sharedlib called in the Jenkinsfile. This approach would enhance the clarity and readability of the code, ensuring a streamlined and efficient testing process.***



#### main.tf:
always_on: keeps the FA (Function App) always on - this is crucial for scenarios where you want to avoid the cold start latency that can occur when a FA is idle and needs to be restarted upon receiving a new request. Keeping the FA always running ensures faster response times and improved performance. However this setting can be changed to ***false*** to reduce running costs.


minimum_instances & maximum_instances: Sets the minimum and maximum instances for scaling. By setting these parameters, you can customise the scaling behavior to meet specific performance needs. Additionally, establishing a maximum limit prevents excessive scaling, thereby controlling resource consumption and optimising costs.


auth_settings: Manages authentication settings, including AAD config. This config ensures secure access control by integrating with AAD.


virtual_network_subnet_id: Links the FA to a specific virtual network subnet. This allows the FA to securely communicate with resources within the same virtual network, such as databases or other services, without exposing traffic to the public internet. It enhances security by ensuring that data stays within the private network and helps maintain compliance with internal policies and regulations regarding network security.


ip_restrictions: Sets IP restrictions for accessing the FA. This feature enhances security by ensuring that only authorised IP addresses can access the FA, thereby preventing unauthorised access.


This configuration ensures that the FA is properly set up with security, scaling, and network settings, allowing it to run efficiently and securely in the Azure environment.



#### rbac.tf:
These configs ensure that only FAs with specific requirements (e.g., access to App Configuration or Key Vault) are granted the necessary permissions. This approach enhances security by following the principle of least privilege, and it automates the role assignments and access policies based on the configuration settings.

***note: again, I am aware this isn't probably structually correct. However, my primary goal is to convey that depending on the needs of the FA, permissions for secret or key access will be granted accordingly. This approach follows the principle of least privilege, ensuring that only the necessary permissions are provided based on the specific requirements of each FA.***



#### service_plan.tf:
ignore_changes - prevents unnecessary updates or conflicts that might arise from changes made outside of Terraform, thus maintaining a consistent and stable infrastructure state as managed by Terraform.
    
tier / size - these changes allow you to customise the service plan based on performance and cost requirements, ensuring that the FAs have the appropriate resources to operate efficiently and are cost effective.



#### storage.tf 
The network_rules block in my azurerm_storage_account resource is added to enhance the security and accessibility of the storage account by defining network access rules.

Specifies the default action to take when no specific network rule matches the request (deny).

Defines a list of virtual network subnet IDs that are allowed to access the storage account. This restricts access to the storage account to only those resources within the specified virtual network subnets, enhancing security by ensuring that only trusted network segments can interact with the storage account. This restricts access to the storage account to specific virtual network subnets and trusted services, reducing the risk of unauthorised access.



## Future Enhancements:

• Enhance monitoring by integrating with Azure Monitor, Application Insights, and other monitoring tools to gain deeper insights into the health and performance of my resources - especially that of the FAs

• Create more detailed custom alerts for my resources

• Enable Key Vault Firewall to only let access from designated IP addresses, or virtual networks, to ensure vault is only accessible from reliable sources

• Add a "backend "azurerm" {}", to enable versioning for remote state storage to keep track of changes and allow for rollbacks if needed. Implement state locking to prevent concurrent updates to the state file, ensuring data integrity. Ensure that data stored in backend storage is encrypted at rest to protect sensitive information. Use SSL/TLS to encrypt data in transit between Terraform and the remote backend storage. Set automated backups for state files to prevent data loss and ensure recovery incase of accidental deletion or corruption. Define retention policies for backups to manage storage costs and compliance requirements

• Breakdown Terraform config into smaller, reusable modules to improve readability and maintainability, e.g., modules/key_vault

• Create Jenkins shared libraries in separate repos to enhance readability and maintain clear, organised code - these will then be referenced in the Jenkinsfile

• Add extensive integration and unit tests to my FA

• Enhance the functionality of my FA

• Improve and restructure the key/secret permissions and access

• Implementing automated secret rotation and audit access to secrets regularly

• Integrate Azure cost management and billing tools to monitor and optimise costs associated with my resources 

• Implement consistent resource tagging to track and manage resources effectively (tried to show in tags with cmdb_appid), aiding in cost analysis and management

• Use Azure Policy to enforce compliance and governance policies, ensuring that all resources adhere to organisational standards (tried to show with inspec check stage in Jenkinsfile, as that is what I currently do now)

• Implement autoscaling for FA and other resources to handle varying workloads efficiently




***p.s apologies in advance for all of this you had to read - I hope you had a coffee and a snack with you***