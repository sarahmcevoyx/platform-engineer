# platform-engineer


ROOT:
added Gemfile
added Jenkinsfile
updated main.tf
updated variables.tf
added outputs.tf 
added scrits folder - update changelog 
added env folder - tst/bld/prd
added codeowners file
added changelog.md


Modules/windows_platform_app:

***Important Note:***
***Due to limited access to the Azure platform, this implementation is based on theoretical knowledge and what I would put into practice. While some details may not reflect my exact implementation approach, the overall strategy remains consistent with my planned solutions. Further explanation will be provided within this readme and when I speak about it.***


### CODEOWNERS:
I have included a github folder containing the CODEOWNERS file. This file defines specific read and write privileges for designated teams. To safeguard the code from unauthorised changes, teams without the necessity for editing will have their write permissions restricted. Additionally, more sensitive files, such as the Jenkinsfile and those within the modules folder, will require a higher level of approval (@authorised_team)


### CHANGELOG.md
A CHANGELOG.md file is crucial for maintaining transparency, as it provides a clear record of all changes made to the project. It facilitates effective communication among team members and users by documenting new features, bug fixes, and updates. Additionally, it supports version control and accountability, ensuring that modifications are easily traceable and manageable.


### versions.tf:
Having the versions.tf file in both my root directory and modules directory ensures that the entire config, including all modules, uses consistent versions of Terraform and its providers. Specifying versions helps avoid unexpected changes due to provider updates, ensuring that infrastructure remains stable, predictable and maintable. 


### outputs.tf:
An output.tf file is essential for providing visibility into the values of created resources, facilitating the integration and automation of infrastructure. Including this file in both the root directory and modules ensures modularity and centralisation, enabling seamless information sharing and management across the entire Terraform config.


### scripts:
I have integrated a script into the Jenkins pipeline to automate updates to the CHANGELOG.md file. This ensures that the changelog remains accurate and up-to-date.

***note: other scripts can be added here, such as a hook.py/hook.tf.*** 

***hook.tf - defines how to use the hook.py script to manage and execute plugin.s***

***hook.py - script that handles the loading and execution of specific methods from plugins stored in a Git repo. Ensures only one instance of the script runs atr a time to avoid conflicts.***


Gemfile:
By specifying the Ruby version and sourcing the necessary gem in my confg file, along with automating the installation of Bundler and the project's dependencies in my Jenkinsfile, I enable the pipeline to run kitchen-terraform. 

***note: nexus is my choice of repo manager as that is what I currently use.***


### env:
I have added an env folder with empty TST, BLD, and PRD subfolders as placeholders. Ideally, this repository should serve as a Terraform module to define the config, while a separate repository should handle the deployment of the Windows platform app. However, for the purpose of this assessment, these subfolders demonstrate that individual config can be added for each respective environment, facilitating specific deployments.


### modules:
The modules folder contains reusable, self-contained Terraform configs. Each module within this folder is designed to manage specific infrastructure components or services. By organising your Terraform code into modules this promotes modularity and maintainability, allowing for easier management, updates, and reuse across different projects or envs. This structure also enhances the scalability and consistency of IaC practices.

Within the modules folder, I have created a functions folder dedicated to the creation of new functions. Inside it, there is a test folder that currently contains a simple unit test. This folder is intended to also accommodate integration tests for subsequent functions. Thoroughly testing these functions before deployment is crucial to ensure their functionality and prevent the deployment of faulty function apps.

***note: Ideally, these tests should be integrated into the Jenkins pipeline or a Jenkins shared library. This approach would enhance the clarity and readability of the code, ensuring a streamlined and efficient testing process.***