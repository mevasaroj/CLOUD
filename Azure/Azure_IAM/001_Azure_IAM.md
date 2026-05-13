# 1. Azure Identity and Access Management (IAM) 
 - Azure Identity and Access Management (IAM) is a framework ensuring the right users, applications, or devices have access to the correct resources at the right time. 
 - It uses Microsoft Entra ID (formerly Azure AD) to manage identities, implementing Role-Based Access Control (RBAC) to define what authenticated users can do (e.g., Owner, Contributor, Reader).

## 2. IAM core functionality
 - **Identity management**: The process of creating, storing, and managing identity information. Identity providers (IdP) are software solutions that are used to track and manage user identities, as well as the permissions and access levels associated with those identities.
 - **Identity federation**: Allow users who already have passwords elsewhere (for example, in your enterprise network or with an internet or social identity provider) to access your system.
 - **Provisioning and deprovisioning of users**: Create and manage user accounts, including specifying which users can access which resources and assigning permissions and access levels.
 - **Authentication of users**: Confirm that a user, machine, or software component is who or what they claim to be.
 - **Authorization of users**: Ensures a user is granted the exact level and type of access to a tool they're entitled to.
 - **Access control**: The process of determining who or what has access to which resources. This process includes defining user roles and permissions, as well as setting up authentication and authorization mechanisms. Access controls regulate access to systems and data.
 - **Reports and monitoring**: Generate reports about platform actions (such as sign-in time, systems accessed, and type of authentication) to ensure compliance and assess security risks.

## 3. Key IAM concepts in Azure include:
 - **Authentication (Who)**: Verifies the identity of a user or service (e.g., signing in with credentials).
 - **Authorization (What)**: Determines the permissions granted to an identity after authentication, such as allowing read-only access to a virtual machine.
 - **Azure RBAC (Role-Based Access Control)**: Manages access by assigning roles to users, groups, or applications at specific scopes (subscription, resource group, or resource).
 - **Core Roles**
    - **Owner**: Full access to all resources, including permission to delegate access.
    - **Contributor**: Full access to manage all resources but cannot assign roles.
    - **Reader**: Can view existing resources but cannot make changes.
 
## 4. Microsoft Entra ID:
 - Microsoft Entra ID (formerly Azure Active Directory) is a cloud-based identity and access management (IAM) service, acting as the central security gate for Azure, Microsoft 365, and other apps.
 - It manages user authentication (logging in) and authorization (what they can access) for users, groups, devices, and applications.

### 4.1. Key Concepts in an Entra ID:
 - **Identity & Security**: Entra ID enables secure access using single sign-on (SSO) to many applications with one set of credentials. It supports multi-factor authentication (MFA) to prevent unauthorized access.
 - **Users and Groups**: You can manage internal employees and external guests. Organizing users into groups simplifies the assignment of permissions.
 - **Role-Based Access Control (RBAC)**: Entra ID is crucial for assigning roles (like Owner, Contributor, Reader) to resources, ensuring users have the appropriate access level.
 - **Conditional Access**: A premium feature that acts as an intelligent gate-keeper, allowing you to set policies based on conditions like user location, device compliance, or risk level.
 - **Hybrid Identity**: Organizations can synchronize on-premises Active Directory with Entra ID to allow users to use the same credentials for both on-premises and cloud resources.
 - **Tenant & Domain**: When signing up for Azure, a dedicated, default tenant domain (e.g., test.onmicrosoft.com) is created, acting as the central container for your identity resources.
 
### 4.2. Set Up Azure Entra ID:
 - In the Azure Portal, search for **Entra ID** or go to **Microsoft Entra ID**.
 - Click on **+ Create a tenant**
 - Choose **Microsoft Entra ID** (not B2C).
 - Enter Org Name (e.g.,"my Lab")
 - Enter Initial Domain Name (mydevlab.onmicrosoft.com)
 - Choose a region - **India**
 - Click Review + Create → then Create.

## 5. Microsoft Entra Domain Services:
 - Microsoft Entra Domain Services
 - Microsoft Entra tenants come with an initial domain name like *domainname.onmicrosoft.com*. You can't change or delete the initial domain name, but you can add your organization's DNS name as a custom domain name and set it as primary.

### 5.1. Add custom domain name
 - Sign in to the Microsoft Entra admin center as at least a Domain Name Administrator.
 - Browse to **Entra ID** --> Domain names > Add custom domain.
 - In Custom domain name, enter your organization's domain --> Select **Add domain**.
 - The unverified domain showing the DNS information needed to validate your domain ownership. Save this information.
 - After you add your custom domain name, you must return to your domain registrar and add the DNS information you copied from the previous step. Creating this TXT or MX record for your domain verifies ownership of your domain name.
 - Go back to your domain registrar and create a new TXT or MX record for your domain based on your copied DNS information. Set the time to live (TTL) to 3600 seconds (60 minutes), and then save the record
