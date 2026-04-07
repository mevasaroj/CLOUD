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
 
