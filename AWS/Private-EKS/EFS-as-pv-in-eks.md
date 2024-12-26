#  EFS as Persistent Volume in AWS EKS
## 1. Create EFS Role.
###  1.1.  Create Custom EFS Policy
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
- [Create **efs-as-pv-in-eks** role](https://github.com/mevasaroj/CLOUD/blob/main/AWS/IAM/06_00_efs-as-pv-in-eks-role.md)
- 

### 2. Add EFS Add-Ons.

### 3. Add EFS Add-Ons.

### 4. Add EFS Add-Ons.

### 5. Add EFS Add-Ons.
