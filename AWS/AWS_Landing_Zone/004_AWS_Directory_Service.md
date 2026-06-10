# AWS Directory Service
 - It allows you to run and manage Microsoft Active Directory (AD) in the cloud or connect your existing on-premises directory to AWS.
 - It provides a centralized way to manage user identities, single sign-on (SSO), and access permissions across AWS resources and compatible applications.

### Core Use Cases
 - **Single Sign-On (SSO)**: Enables your users to log in to the AWS Management Console and business applications using their standard corporate AD credentials, avoiding multiple logins
 - **Centralized Access Control**: IT administrators manage policies, devices, and user permissions across both on-premises and cloud environments seamlessly.

### Primary Directory Types
 - **AWS Managed Microsoft AD**: A fully functional, actual Microsoft Active Directory hosted and maintained by AWS.
 - **AD Connector**: A directory gateway (or proxy) that allows your existing on-premises Active Directory to handle authentication for AWS services. No directory data is stored in the cloud.
 - **Simple AD**: A cost-effective, Samba 4-based directory service managed by AWS. It provides basic AD features (like user and group management, joining EC2 instances) but does not support trusts with an on-premises AD or some advanced enterprise features.

### How to configure AWS Directory Service
 - Following process need to perform to configure the AWS Directory Service
    - Set up Directory
    - Set up Application access URL
    - Enable the AWS Management Console
    - Delegate console access
  

##### Set up Directory
 - Sign in to the **AWS Management Console** --> navigate to **Directory Service** under **Active Directory** Left Side
 - Click **Set up directory** and select **AD Connector**
 - Choose your directory size (**Small** or **Large**).
 - Choose the specific **VPC** and at least **two Subnets**
 - Enter your existing directory information
    - Directory DNS name: The fully qualified domain name (FQDN) of your existing directory (e.g., corp.example.com).
    - Directory NetBIOS name: The short name of your domain (e.g., CORP).
    - DNS IP addresses: The IP addresses of your on-premises DNS servers.
   - Click **Next**, review your settings, and choose **Create directory**
  
#### Set up Application access URL
 - Sign in to the **AWS Management Console** --> navigate to **Directory Service** under **Active Directory** Left Side
 - Click on Directory ID created in abo e steps (Directory Name = corp.example.com)
 - On the **Directory details** page, choose the **Application management tab**.
 - On **Application access URL** section, choose **Create** At the top-right corner
 - In the **Create application access** URL pop-up window:
    - For Access URL name, = Enter the Directory NetBIOS name (Such as CORP)  
 - Choose **Create**

#### Enable the AWS Management Console
 - Sign in to the **AWS Management Console** --> navigate to **Directory Service** under **Active Directory** Left Side
 - Click on Directory ID created in abo e steps (Directory Name = corp.example.com)
 - On the **Directory details** page, choose the **Application management tab**.
 - Scroll Down to **AWS Management Console** section, --> **Actions** --> Click **Enable**
   
#### Delegate console access 
 - Sign in to the **AWS Management Console** --> navigate to **Directory Service** under **Active Directory** Left Side
 - Click on Directory ID created in abo e steps (Directory Name = corp.example.com)
 - On the **Directory details** page, choose the **Application management tab**.
 - Scroll Down to **Delegate console access** section, --> Add the user as per group.
