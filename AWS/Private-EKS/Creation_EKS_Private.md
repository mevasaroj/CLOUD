# How to create Private EKS Cluster
## Following Roles Require.
1. AWSServiceRoleForAmazonEKS
   ```hcl
   Create as follow
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
4. Worker Node Role
5. EKSServiceRole
6. AWSServiceRoleForAmazonEKS
7. TFE Role
