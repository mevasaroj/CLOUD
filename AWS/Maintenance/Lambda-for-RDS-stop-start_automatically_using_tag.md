# How_to_Schedule_Lambda-for-RDS-stop-start_automatically_using_tag
## 1. Apply the following tag to RDS instance / cluster.
- Please add below tag to all RDS instances / cluster .
  - Key = AutoRestart
  - Value = True

## 2. Create Lamdba Role.
- 2.1. Create Custom Policy
   1. Open **IAM** --> Click **Policies**
   2. Click **Create Policies**
   3. Select JSON --> Add Following Custom Policies
      - [rds_stop_start_policy](https://github.com/mevasaroj/CLOUD/blob/main/AWS/Maintenance/rds_stop_start_policy.json)
   
   4. Click **Next**
   
   5. Under **Review and create**
        - Policy name = **rds_stop_start_policy**
        - Description - optional = **Type Description**
        - Add tags - optional = **Type the require tags**

   6. Click **Create Policy**
   
   
- 2.2. Create Custom Role
     1. Open IAM --> Roles
     2. Create Role   
     3. Select the Following - Under : **Trusted entity type**
          - Trusted entity type : **AWS service**
          - Use cases : type **"Lambda"** --> Select **Lambda** --> First Option

     4. Add permission :
         - Search above custom Policy = **rds_stop_start_policy** --> Click Next
   
     5. Under Name, review, and create 
        - Role name = **rds_stop_start_role**
       - Description = **Default**
        - Step 1: Select trusted entities = **No Change**
        - Step 2: Add permissions = **No Change**
        - Step 3: Add tags = **Add require tags**

     6. Click **Create Role**
   

## 3. Create 2 Lamdba Function.
### 3.1. To stop the RDS instance / cluster
#### 3.1.1. Create Lamdba Function - To Stop RDS
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **rds_stop_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **rds_stop_start_role**

   4. Click **Create Function**
   

#### 3.1.2. Update Lamdba Function Code as below - To Stop RDS
 - To Stop **RDS Cluster** Update the below Code
      - [rds-cluster-stop.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/rds-cluster-stop.py)
   
    
 - To Stop **RDS Instance** Update the below Code
      - [rds-instance-stop.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/rds-instance-stop.py)
   

### 3.2. To start the RDS instance / cluster
#### 3.2.1. Create Lamdba Function - To Start RDS
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **rds_start_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **rds_stop_start_role**

   4. Click **Create Function**
   

#### 3.2.2. Update Lamdba Function Code as below - To Start RDS
  - To Start **RDS Cluster** Update the below Code
      - [rds-cluster-start.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/rds-cluster-start.py)
   
    
  - To Start **RDS Instance** Update the below Code
      - [rds-instance-start.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/rds-instance-start.py)
   
## 4. Create 2 Amazon EventBridge Rule.
### 4.1. To stop the RDS instance / cluster
   1. Open the **Amazon Console** --> Type **Event** in Search --> Open **Amazon EventBridge**
   2. Click **Schedules** --> Click **Create schedule**
   4. Under **Specify schedule detail**
       - Under **Schedule name and description**
          - Schedule name = **rds_stop_rule**
          - Description - optional = **Type Description**
          - Schedule group = **Default**
            
       - Under **Schedule pattern**
           - Occurrence = Select **Recurring schedule**
           - Time zone = **(UTC +5:30) Asia/Culcutta**
           - Schedule type = **Cron-based schedule**
              - **cron** (00 05 ? * 2-6 *) --> This will run (Monday - Friday @5.00 IST)
              - **cron** (00 05 ? * 2 *) --> This will run Only on Monday  @5.00 IST
              - **cron** (00 05 * * ? *) --> This will run Daily - @5.00 IST
           - Flexible time window =**Off**
           -
           - a
       - Event bus name = **Default**
       - Activation = **Active**
       - Tags - optional = **Add Require Tags**


   5.
   6.
   7.
   8.
   9. a
      
### 4.2. To start the RDS instance / cluster
   1.
   2.
   3.
   4.
   5.
   6.
   7.
   8. a





