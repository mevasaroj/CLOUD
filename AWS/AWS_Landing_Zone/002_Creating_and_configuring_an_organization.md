# 1. Creating and configuring an organization
 - In this tutorial, you create your organization and configure it with two AWS member accounts.
 - We create one of the member accounts in your organization, and invite the other account to join an organization.

### 1.2. The following illustration shows the main steps of the tutorial.
 - Step 1: Create your organization :
    - In this step, We create an organization with current AWS account as the management account.
    - Also invite one AWS account to join an organization, and create a second account as a member account.
  
 - Step 2: Create the organizational units
    - We create two organizational units (OUs) in your new organization and place the member accounts in those OUs.
  
 - Step 3: Create the service control policies
    - We create two SCPs and attach them to the OUs in your organization.
  
 - Step 4: Testing your organization's policies
    - can sign in as users from each of the test accounts and see the effects that the SCPs have on the accounts.
  
### 1.3. Prerequisites
 - This tutorial assumes that we have access to two existing AWS accounts without any resource in that and that can sign in to each as an administrator.
 - We create a third as part of this tutorial.

## 2. Step 1: Create your organization
 - Sign in to designated management account with administrator access --> open the **AWS Organizations console**
 - On the introduction page, choose **Create an organization**
 - Review the confirmation dialog box and click **Create an organization** again.
 - **Verify your email**: Check your inbox for a verification email sent by AWS and verify it within 24 hours.

### 2.1. Invite an existing account to join your organization
 - Sign in to **management account** --> Navigate to the **AWS accounts** --> choose **Add an AWS account** Right Top
 - Under **Add an AWS account** Page
    - Select **Invite an existing AWS account**
    - Email address or account ID of an AWS account to invite box, = enter the email address of the owner of the account that you want to invite
    - Message to include in the invitation email message - optional = Type Message
    - Tags = Add Tags
    - Click **Send Invitation**
  
 - On Target Account
    - Open the email that AWS sent from the management account and choose the link to accept the invitation --> Sign into AWS Console
    - On the **AWS accounts** page, choose **Accept** and then choose **Confirm**
  
 - Sign out of your member account and sign in again as an administrator in **management account**


### 2.2. Create a member account
 - Sign in to **management account** --> Navigate to the **AWS accounts** --> choose **Add an AWS account** Right Top
 - Under **Add an AWS account** --> Choose **Create an AWS account** radio button
 - Under **Create an AWS account**
    - AWS account name = hbl-aws-adobepl-prod
    - Email address of the account's owner =  Enter Root Email Address
    - IAM role name = leave this blank to automatically use the default role name of *OrganizationAccountAccessRole*
    - Tags = Add Tags
  
 - Click **Create AWS Account** Button at Bottom


## 3. Step 2: Create the organizational units
 - In the steps in this section, We create 2 organizational units (OUs) mentioned below and place each member accounts in each of them.
    - Production OU
    - UAT OU
      
 - When done, hierarchy looks like the following illustration.
    - The management account remains in the root.
    - One member account is moved to the Production OU.
    - other member account is moved to the UAT OU
  
### 3.1. Create an OU
 - Sign in to **management account** --> Navigate to the **AWS accounts**
 - Choose the **check box Blue** checkmark  next to the **Root** container.
 - Choose the **Actions** dropdown, and then under **Organizational unit**, choose **Create new**
 - Under **Create organizational unit in Root** Page
    - Organizational unit name = **Production**
    - Add Tags
  
 - choose **Create organizational unit**
 - **Note** = Repeate above steps for **UAT** OU.

### 3.2. Move Existing AWS account into an OU


https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tutorials_basic.html
