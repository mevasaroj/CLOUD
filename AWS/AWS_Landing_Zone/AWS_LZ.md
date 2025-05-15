# AWS Landing Zone
 - A landing zone is a well-architected, multi-account AWS environment that is scalable and secure.
 - It provides a baseline to get started with multi-account architecture, identity and access management, governance, data security, network design, and logging.
 - AWS offers its Control Tower service, which functions as a landing zone as a service.
 - AWS Control Tower automates the setup of a new landing zone using best-practices blueprints for identity, federated access, and account structure.

# AWS Control Tower 
- It is a service that simplifies setting up and managing a multi-account AWS environment while adhering to AWS best practices.
- It automates the process of creating a landing zone, which is a secure and compliant environment for enterprises, and applies controls (rules) to enforce policies and guardrails.
- Control Tower integrates with other AWS services like AWS Organizations, AWS Service Catalog, and IAM Identity Center to streamline the process. 

##### Diagram Landing Zone

<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/AWS_Landing_Zone/Architect_Diagram/aws-control-tower.png" width="900" />


### AWS Organization Root
 - A root is a top-level parent node in the hierarchy of an organization that can contain organizational units (OUs) and accounts.
 - AWS Organizations enables centralized management of AWS accounts, organizational units, and policies for security, backup, tagging, and chatbots.
 - An organizational unit (OU) is a group of other organization unit and AWS accounts within an organization.

##### Diagram Organization Unit
<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/AWS_Landing_Zone/Architect_Diagram/AWS_OU.jpg" width="600" />

