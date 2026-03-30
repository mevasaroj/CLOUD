# How_to_Schedule_Lambda-for-RDS-stop-start_automatically_using_tag
### 1. Apply the following tag to RDS instance / cluster.
- Please add below tag to all RDS instances / cluster .
  - Key = AutoRestart
  - Value = True

### 2. Create Lamdba Role.
- 2.1. Create Custom Policy
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
```
