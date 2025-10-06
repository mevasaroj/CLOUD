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
3. Worker Node Role
4. EKSServiceRole
5. AWSServiceRoleForAmazonEKS
6. TFE Role
