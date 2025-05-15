# AWS Landing Zone
 - A landing zone is a well-architected, multi-account AWS environment that is scalable and secure.
 - It provides a baseline to get started with multi-account architecture, identity and access management, governance, data security, network design, and logging.
 - AWS offers its Control Tower service, which functions as a landing zone as a service.
 - AWS Control Tower automates the setup of a new landing zone using best-practices blueprints for identity, federated access, and account structure.

# AWS Control Tower 
- **Automated Landing Zone Setup**: Control Tower automates the creation of a landing zone, which is a multi-account AWS environment configured to follow best practices.
- **Governance and Compliance**: It enforces mandatory and optional controls, called "guardrails," to ensure compliance with policies and recommended practices.
- **Multi-Account Management**: It helps organizations manage and govern multiple AWS accounts, ensuring they align with established compliance policies.
- **Account Provisioning**: It enables end users to provision new AWS accounts quickly using configurable account templates.
- **Centralized Visibility**: The Control Tower dashboard provides continuous visibility into the AWS environment, allowing for monitoring and control.
- **Security and Compliance**: It helps ensure that security logs and necessary cross-account access rights are in place.
- **Integration with AWS Services**: It leverages the capabilities of other AWS services like AWS Organizations, AWS Service Catalog, and IAM Identity Center.
- **Preventive and Investigative Controls**: It uses preventive and investigative controls to help prevent organizations and accounts from straying from recommended practices. 

##### Diagram Landing Zone

<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/AWS_Landing_Zone/Architect_Diagram/aws-control-tower.png" width="900" />


### AWS Organization Root
 - A root is a top-level parent node in the hierarchy of an organization that can contain organizational units (OUs) and accounts.
 - AWS Organizations enables centralized management of AWS accounts, organizational units, and policies for security, backup, tagging, and chatbots.
 - An organizational unit (OU) is a group of other organization unit and AWS accounts within an organization.

##### Diagram Organization Unit
<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/AWS_Landing_Zone/Architect_Diagram/AWS_OU.jpg" width="600" />

