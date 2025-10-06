# How to create Private EKS Cluster
### Following Roles Require.
1. AWSServiceRoleForAmazonEKS
   - Create as follow
   ```hcl
   1. Open IAM --> Roles
   2. Create Role
   
   3. Select the Following
         Use cases for other AWS services: type "EKS"
   
   4. Select "EKS" - First Option
   5. Add permission : (Default)
   6. Name = Default = AWSServiceRoleForAmazonEKS
   7. Create
   ```
   
2. EKS Cluster Role
   - Follow the below steps
     ```hcl
     1. Click on Roles
     2. Click on Create Role
     
     3. Select the Following : 
	        Trusted entity type : AWS Service
	        Use case : under Use cases for other AWS services: Type EKS
     
     4. Select "EKS Cluster" - 2nd Option --> Click Next
     5. Under Add Permissison : Default - AmazonEKSClusterPolicy --> Click Next
     6. Also Add  KMS Key Permission --> Create Custom KMS Key Policy
     
     7. Name, review, and create	
	      Role name : hbl-aws-aps1-appname-uat-eks-cluster-role
	        Tags:
	          Name : hbl-aws-aps1-appname-uat-eks-cluster-role
	          Environment : uat
	          ProjectID :
     
     8. Click Create Roles
   ```
   
3. Worker Node Role
   - Follow the below steps
     ```hcl
     1. Click on Roles
     2. Click on Create Role
     
     3. Select the Following : 
	      Trusted entity type : AWS Service
	      Use case : EC2
     
     4. Under Add Permissison : Following AWS Permission --> Click Next
	      AmazonEKSWorkerNodePolicy
	      AmazonEC2ContainerRegistryReadOnly
	      AmazonSSMManagedInstanceCore
	      AmazonEKS_CNI_Policy
	      AmazonEC2RoleforSSM
          AmazonEFSCSIDriverPolicy
          AmazonEBSCSIDriverPolicy

     5.  Also Add  KMS Key Permission --> Create Custom KMS Key Policy
     
     6. Name, review, and create	
	      Role name : hbl-aws-cam-role-eks-workernode-dlm-prod
	      Tags:
	         Name : hbl-aws-cam-role-eks-workernode-dlm-prod
	         Environment : uat
	         ProjectID :
     
     7. Click Create Roles
     ```


4. TFE Role
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
- Create the following VPC Endpoint with security Group 443 port must allow from entire vpc cidr (Primary and Secodary Boht)
1. com.amazonaws.region.s3 - (Gateway Type)
2. com.amazonaws.region.ec2
3. com.amazonaws.region.ecr.api
4. com.amazonaws.region.ecr.dkr
5. com.amazonaws.region.sts
6. com.amazonaws.region-code.eks
7. com.amazonaws.region-code.eks-auth


### Create Following Security Group
- Create eks security group with all traffic allow from entire vpc cidr (Primary and Secodary Boht)

### Cretae the KMS Key using JSON like https://github.com/mevasaroj/CLOUD/blob/main/AWS/Private-EKS/kms_key_policy

