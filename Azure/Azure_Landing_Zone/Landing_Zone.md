# Azure Landing Zone
 - Azure incorporates the landing zone concept into its Cloud Adoption Framework (CAF), providing a structured and standardized approach to cloud adoption.
 - Azure Landing Zone offer a multi-subscription structure to support organizations in managing their workloads effectively.
 - Azure uses a hierarchical subscription-based model, allowing for logical grouping and resource management.
 - Azure provides a comprehensive set of governance policies, security controls, and built-in compliance measures through Azure Policy, Azure Security Center, and Azure Blueprints.

#### Tenant
 - A Tenant refers to a single dedicated and trusted instance of Azure Active Directory and it gets created automatically when you sign up for a Microsoft cloud service subscription.
 - The Azure AD tenant provides a single place to manage users, groups and their permissions for the applications published in the Azure AD.
 - Tenant can have one or more Subscriptions that depends on organizational requirements and each Subscription has a name, and like Tenants, have a unique identity, called as Subscription ID

#### Subscription
 - Subscriptions logically associate user accounts with the resources that they create.
 - A Subscription in Azure can be considered as a **logical container** into which the **resource group**, resource and services can be **created, configured**, and **installed**.
 - Each subscription has limits or quotas on the amount of resources that it can create and use.
 - Organizations can use subscriptions to manage costs and the resources that are created by users, teams, and projects.

#### Resource Group
 - Resource Group is **logical groups** that can be **create in Subscription**.
 - Resource groups are logical containers where you can deploy and manage Azure resources like virtual machines, web apps, databases, and storage accounts.


#### Resources
 - Resources are instances of services that you can create in a resource group, such as virtual machines, storage, and SQL databases.

[![image](https://github.com/user-attachments/assets/91736f87-6e1a-4b71-8ca7-97bada26b1bb)](https://github.com/mevasaroj/CLOUD/blob/main/Azure/Azure_Landing_Zone/Architect_Diagram/azure-MG-Sub-RG.png)

