# Azure Identity and Access Management (IAM) 
 - Azure Identity and Access Management (IAM) is a framework ensuring the right users, applications, or devices have access to the correct resources at the right time. 
 - It uses Microsoft Entra ID (formerly Azure AD) to manage identities, implementing Role-Based Access Control (RBAC) to define what authenticated users can do (e.g., Owner, Contributor, Reader).

## Key IAM concepts in Azure include:
 - **Authentication (Who)**: Verifies the identity of a user or service (e.g., signing in with credentials).
 - **Authorization (What)**: Determines the permissions granted to an identity after authentication, such as allowing read-only access to a virtual machine.
 - **Azure RBAC (Role-Based Access Control)**: Manages access by assigning roles to users, groups, or applications at specific scopes (subscription, resource group, or resource).
 - **Core Roles**
    - **Owner**: Full access to all resources, including permission to delegate access.
    - **Contributor**: Full access to manage all resources but cannot assign roles.
    - **Reader**: Can view existing resources but cannot make changes
 
## Microsoft Entra ID:
 - Microsoft Entra ID (formerly Azure Active Directory) is a cloud-based identity and access management (IAM) service, acting as the central security gate for Azure, Microsoft 365, and other apps.
 - It manages user authentication (logging in) and authorization (what they can access) for users, groups, devices, and applications.

## Key Concepts in an Entra ID:
 - **Identity & Security**: Entra ID enables secure access using single sign-on (SSO) to many applications with one set of credentials. It supports multi-factor authentication (MFA) to prevent unauthorized access.
 - **Users and Groups**: You can manage internal employees and external guests. Organizing users into groups simplifies the assignment of permissions.
 - **Role-Based Access Control (RBAC)**: Entra ID is crucial for assigning roles (like Owner, Contributor, Reader) to resources, ensuring users have the appropriate access level.
 - **Conditional Access**: A premium feature that acts as an intelligent gatekeeper, allowing you to set policies based on conditions like user location, device compliance, or risk level.
 - **Hybrid Identity**: Organizations can synchronize on-premises Active Directory with Entra ID to allow users to use the same credentials for both on-premises and cloud resources.
 - **Tenant & Domain**: When signing up for Azure, a dedicated, default tenant domain (e.g., test.onmicrosoft.com) is created, acting as the central container for your identity resources.
 
## Set Up Azure Entra ID:
 - In the Azure Portal, search for **Entra ID** or go to Microsoft Entra ID.
 - Click on **+ Create a tenant**
 - Choose **Microsoft Entra ID** (not B2C).
 - Enter Org Name (e.g.,"my Lab")
 - Enter Initial Domain Name (mydevlab.onmicrosoft.com)
 - Choose a region - **India**
 - Click Review + Create → then Create.
