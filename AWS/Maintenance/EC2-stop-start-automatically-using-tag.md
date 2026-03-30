# How-to-Schedule-Lambda-for-EC2-stop-start-automatically-using-tag
## 1. Apply the following tag to EC2 instance / cluster.
- Please add below tag to all RDS instances / cluster .
  - Key = **AutoRestart**
  - Value = **True**

## 2. Create Lamdba Role.
- 2.1. Create Custom Policy
   1. Open **IAM** --> Click **Policies**
   2. Click **Create Policies**
   3. Select JSON --> Add Following Custom Policies
      - [ec2_stop_start_policy](https://github.com/mevasaroj/CLOUD/blob/main/AWS/Maintenance/ec2_stop_start_policy.json)
   
   4. Click **Next**
   
   5. Under **Review and create**
        - Policy name = **ec2_stop_start_policy**
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
         - Search above custom Policy = **ec2_stop_start_policy** --> Click Next
   
     5. Under Name, review, and create 
        - Role name = **ec2_stop_start_role**
       - Description = **Default**
        - Step 1: Select trusted entities = **No Change**
        - Step 2: Add permissions = **No Change**
        - Step 3: Add tags = **Add require tags**

     6. Click **Create Role**
   

## 3. Create 2 Lamdba Function.
### 3.1. To stop the EC2 instance.
#### 3.1.1. Create Lamdba Function - To Stop EC2
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **ec2_stop_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **ec2_stop_start_role**

   4. Click **Create Function**
   

#### 3.1.2. Update Lamdba Function Code as below - To Stop EC2
 - To Stop **EC2 instacne** Update the below Code
      - [ec2-stop.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/ec2-stop.py)
   

### 3.2. To start the RDS instance / cluster
#### 3.2.1. Create Lamdba Function - To Start RDS
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **rds_start_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **ec2_stop_start_role**

   4. Click **Create Function**
   

#### 3.2.2. Update Lamdba Function Code as below - To Start RDS
  - To Start **EC2 Instance** Update the below Code
      - [ec2-start.py](https://github.com/mevasaroj/CLOUD/blob/main/Python/Python_Script/ec2-start.py)
   
## 4. Create 2 Amazon EventBridge Rule.
### 4.1. To stop the RDS instance / cluster
   1. Open the **Amazon Console** --> Type **Event** in Search --> Open **Amazon EventBridge**
   2. Click **Schedules** --> Click **Create schedule**
   3. Under **Specify schedule detail**
       - Under **Schedule name and description**
          - Schedule name = **ec2_stop_rule**
          - Description - optional = **Type Description**
          - Schedule group = **Default**
            
       - Under **Schedule pattern**
           - Occurrence = Select **Recurring schedule**
           - Time zone = **(UTC +5:30) Asia/Culcutta**
           - Schedule type = **Cron-based schedule**
              - For Daily Rule **Day of the week** = **?** OR For any Days of Week **Day of month** = **?**
              - Example
              - **cron** (00  05  ?  *  2-6  *) --> From Monday - To Friday @5.00 IST)
              - **cron** (00  05  ?  *  2,6  *) --> Monday and Friday @5.00 IST)
              - **cron** (00  05  ?  *  2  *) --> Only on Monday  @5.00 IST
              - **cron** (00  05  *  *  ?  *) --> Daily - @5.00 IST
           - Flexible time window =**Off**
           - Timeframe = **No Changes**
       - Click = **Next**
     
   4. Under **Select target**
       - Target detail
          - Target API = **Templated targets**
          - Select = **AWS Lambda**
        
       - Invoke
          - Lambda function = Select **ec2_stop_lambda_function**
        
       - Click --> **Next**
     
   5. Under **Settings - optional**
      - Schedule state = **Enable**
      - Action after schedule completion = **NONE**
      - Retry policy and dead-letter queue (DLQ) = **No Changes**
      - Encryption = **Define Customer KMS Key**
      - Permissions = Select **Use existing role** --> Browse and Select **ec2_stop_start_role**
      - Click --> **Next**
     
   6. Under **Review and create schedule** --> Click **Create schedule**

      
### 4.2. To start the RDS instance / cluster
   1. Open the **Amazon Console** --> Type **Event** in Search --> Open **Amazon EventBridge**
   2. Click **Schedules** --> Click **Create schedule**
   3. Under **Specify schedule detail**
       - Under **Schedule name and description**
          - Schedule name = **ec2_start_rule**
          - Description - optional = **Type Description**
          - Schedule group = **Default**
            
       - Under **Schedule pattern**
           - Occurrence = Select **Recurring schedule**
           - Time zone = **(UTC +5:30) Asia/Culcutta**
           - Schedule type = **Cron-based schedule**
              - For Daily Rule **Day of the week** = **?** OR For any Weekdays **Day of month** = **?**
              - Example
              - **cron** (00  05  ?  *  2-6  *) --> From Monday - To Friday @5.00 IST)
              - **cron** (00  05  ?  *  2,6  *) --> Monday and Friday @5.00 IST)
              - **cron** (00  05  ?  *  2  *) --> Only on Monday  @5.00 IST
              - **cron** (00  05  *  *  ?  *) --> Daily - @5.00 IST
           - Flexible time window =**Off**
           - Timeframe = **No Changes**
       - Click = **Next**
     
   4. Under **Select target**
       - Target detail
          - Target API = **Templated targets**
          - Select = **AWS Lambda**
        
       - Invoke
          - Lambda function = Select **ec2_start_lambda_function**
        
       - Click --> **Next**
     
   5. Under **Settings - optional**
      - Schedule state = **Enable**
      - Action after schedule completion = **NONE**
      - Retry policy and dead-letter queue (DLQ) = **No Changes**
      - Encryption = **Define Customer KMS Key**
      - Permissions = Select **Use existing role** --> Browse and Select **ec2_start_start_role**
      - Click --> **Next**
     
   6. Under **Review and create schedule** --> Click **Create schedule**
  





