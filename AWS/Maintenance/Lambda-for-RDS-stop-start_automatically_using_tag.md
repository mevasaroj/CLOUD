# How_to_Schedule_Lambda-for-RDS-stop-start_automatically_using_tag
### 1. Apply the following tag to RDS instance / cluster.
- Please add below tag to all RDS instances / cluster .
  - Key = AutoRestart
  - Value = True

### 2. Create Lamdba Role.
- 2.1. Create Custom Policy
   ```hcl
   1. Open IAM --> Policies
   2. Create Policies
   3. Select JSON -->Type the Below Policy
   {
     "Version": "2012-10-17",
     "Statement": [
       {
       "Sid": "RDSSTOPSTART",
       "Effect": "Allow",
       "Action": [
           "rds:Describe*",
           "rds:Start*",
           "rds:Stop*",
           "rds:List*",
           "rds:Reboot*",
           "logs:CreateLogGroup",
           "logs:CreateLogStream",
           "logs:PutLogEvents"
       ],
         "Resource": "*"
       },
       {
       "Sid": "KMSAccess",
       "Effect": "Allow",
       "Action": [
           "kms:Encrypt",
           "kms:Decrypt",
           "kms:ReEncrypt*",
           "kms:CreateGrant"
       ],
       "Resource": [
    		"arn:aws:kms:ap-south-1:911372318716:key/53e2f350-8bed-4d34-bac9-4fb92ea9d8de"
    	]
      }
    ]
   }

   4. Click Next
   
   5. Under **Review and create**
        - Policy name = **rds_stop_start_policy**
        - Description - optional = Type Description
        - Add tags - optional = Type the require tags

   6. Click **Create Policy**
   ```
   
- 2.2. Create Custom Role
   ```hcl
   1. Open IAM --> Roles
   2. Create Role   
   3. Select the Following - Under : **Trusted entity type**
        - Trusted entity type : **AWS service**
        - Use cases : type **"EKS"** --> Select __"EKS"__ --> First Option

   4. Add permission : (Default) --> No Change --> Click Next
   
   5. Under Name, review, and create = Default = No Change --> Click Create Role
   ```
