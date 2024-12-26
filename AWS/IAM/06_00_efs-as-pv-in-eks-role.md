
### Create Custom EFS Policy
- Sign in to the AWS Management Console and open the IAM console at **https://console.aws.amazon.com/iam/**
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Policies__, and then choose __Create policy__.
- Click on JSON 
- Copy and paste the Policy from https://github.com/mevasaroj/CLOUD/blob/main/AWS/IAM/06_01_efs-as-pv-in-eks-policy.tf
- Replace the **KMS Key ARN** at line no. 76 and 77
- Click __Next__
- Under **Review and create** 
   - Policy Name : **efs-as-pv-in-eks-policy**
   - Description : **efs-as-pv-in-eks-policy**
   - Add Tags : Add require tags 
- Click __Create Policy__



### Create EFS Role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
  
- Under : **Select Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
   - Click __Next__
 
- Under **Add permission** --> Type **efs-as-pv-in-eks-policy** & Check Mark it --> Click __Next__

        
- Under **Name, review, and create**
   - Role Name : **efs-as-pv-in-eks-role**
   - Description : **efs-as-pv-in-eks-role**
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

- Click **create role**



### Update the Trust relationship
- Sign in to the AWS Management Console and open the IAM console at **https://console.aws.amazon.com/iam/**
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **efs-as-pv-in-eks-role** from list
- Click **Trust relationships**
- Copy and paste the content from https://github.com/mevasaroj/CLOUD/blob/main/AWS/IAM/06_02_efs-as-pv-in-eks-trust-relation.tf
