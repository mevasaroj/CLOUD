# How to create Private EKS Cluster
### A. Create Following 4 Roles.
#### 1. Create  **AWSServiceRoleForAmazonEKS** role
- 1.A. Create as **AWSServiceRoleForAmazonEKS**
   ```hcl
   1. Open IAM --> Roles
   2. Create Role   
   3. Select the Following - Under : **Trusted entity type**
        - Trusted entity type : **AWS service**
        - Use cases : type **"EKS"** --> Select __"EKS"__ --> First Option

   4. Add permission : (Default) --> No Change --> Click Next
   
   5. Under Name, review, and create = Default = No Change --> Click Create Role
   ```
- 1.B. Also Add  KMS Key Permission --> Create Custom KMS Key Policy as below
  ```hcl
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KMSAccess",
            "Effect": "Allow",
            "Action": [
                "kms:ListGrants",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx",
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx"
        ]
      }
    ]
  }
  ```

- 1.C. Don't change **Trustrelationship** for role **AWSServiceRoleForAmazonEKS** by defualt.

#### 2. Create EKS Cluster Role and Add KMS Policy and Update Trusrelationship
- 2.A. Create **eks-cluster-role**
```hcl
1. Open IAM --> Roles
2. Create Role
3. Select the Following - Under : **Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type **"EKS"** --> Select __"EKS Cluster"__ --> Second Option

4. Under Add permission : **(Default)** --> No Changes --> Click Next

5. Under **Name, review, and create**
   - Role Name : **eks-cluster-role**
   - Description : __No Changes__
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

6. Click **Create role**
```
- 2.B. Also Add Below **KMS Key Permission** --> Create Custom KMS Key Policy as below
  ```hcl
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KMSAccess",
            "Effect": "Allow",
            "Action": [
                "kms:ListGrants",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx",
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx"
        ]
      }
    ]
  }
  ```

- 2.C. Change the **Trustrelationship** for role **eks-cluster-role** as below
```hcl
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```


#### 3. Create eks WorkerNode Role and Add KMS Policy and Update Trusrelationship
- 3.A. Create **eks-workernode-role**
```hcl
1. Open IAM --> Roles
2. Create Role
3. Select the Following - Under : **Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type **"EC2"** --> Select __"EC2"__ --> First Option

4. Under Add Permissison : Add Following AWS Permission --> Click Next
	      AmazonEKSWorkerNodePolicy
	      AmazonEC2ContainerRegistryReadOnly
	      AmazonSSMManagedInstanceCore
	      AmazonEKS_CNI_Policy
	      AmazonEFSCSIDriverPolicy
          AmazonEBSCSIDriverPolicy

5. Under **Name, review, and create**
   - Role Name : **eks-workernode-role**
   - Description : __No Changes__
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

6. Click **Create role**
```
- 3.B. Also Add Below **KMS Key Permission** --> Create Custom KMS Key Policy as below
  ```hcl
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KMSAccess",
            "Effect": "Allow",
            "Action": [
                "kms:ListGrants",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx",
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx"
        ]
      }
    ]
  }
  ```

- 3.C. Change the **Trustrelationship** for role **eks-workernode-role** as below
```hcl
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::281845296445:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/F1DAD3723D26A9A90485AE47616D1F37"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/F1DAD3723D26A9A90485AE47616D1F37:sub": [
                        "system:serviceaccount:kube-system:efs-csi-controller-sa",
                        "system:serviceaccount:kube-system:ebs-csi-controller-sa",
                        "system:serviceaccount:kube-system:efs-csi-node-sa"
						],
                    "oidc.eks.ap-south-1.amazonaws.com/id/F1DAD3723D26A9A90485AE47616D1F37:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```


#### 4. Create Terraform Role and Add KMS Policy and Update Trusrelationship
   - Create the policy using policy define in folder https://github.com/mevasaroj/CLOUD/tree/main/AWS/Private-EKS/TFE_Policy
   - Create ***Role***
     	- __Create role__.
     	- Under : **Select Trusted entity type**
     	- Trusted entity type : **AWS service**
     	- Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
     	- Click __Next__
     	- Add Permission = Add both policy created above --> Create
     	- 
   - Create TFE ***Trust relationship***
     ```hcl
     {
     "Version": "2012-10-17",
     "Statement": [
     {
     "Effect": "Allow",
     "Principal": {
     "AWS": "arn:aws:iam::516664790770:user/hbl-aws-user-tfeappinfra-sharedservices-infra-uat"
     },
     "Action": "sts:AssumeRole"
     }
     ]
     }
     ```

### Following VPC ENDPOINTS Require.
- Create the following VPC Endpoint with security Group 443 port must allow from entire vpc cidr (Primary and Secodary Both)
1. com.amazonaws.region.s3 - (Gateway Type)
2. com.amazonaws.region.ec2
3. com.amazonaws.region.ecr.api
4. com.amazonaws.region.ecr.dkr
5. com.amazonaws.region.sts
6. com.amazonaws.region-code.eks
7. com.amazonaws.region-code.eks-auth


### Create Following Security Group
- Create eks security group with all traffic allow from entire vpc cidr (Primary and Secodary Both)

##### Cretae the KMS Key using JSON like https://github.com/mevasaroj/CLOUD/blob/main/AWS/Private-EKS/kms_key_policy

##### Run the following command during terraform run once clester is created

```hcl
aws kms create-grant \
--region ap-south-1 \
--key-id "arn:aws:kms:ap-south-1:911372318716:key/mrk-0f78d2f68ed04b6e8256bf7358548a20" \
--grantee-principal arn:aws:iam::048599826367:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling \
--operations "Encrypt" "Decrypt" "ReEncryptFrom" "ReEncryptTo" "GenerateDataKey" "GenerateDataKeyWithoutPlaintext" "DescribeKey" "CreateGrant"
```
  

##### Cretae the EKS Cluster with Launch Template https://github.com/mevasaroj/CLOUD/blob/main/AWS/Terraform/eks-cluster-with-lt-bottlerocket.tf

##### Cretae the EKS Cluster without Launch Template https://github.com/mevasaroj/CLOUD/blob/main/AWS/Terraform/eks_cluster_without-lt-v6_bottlerocket.tf
