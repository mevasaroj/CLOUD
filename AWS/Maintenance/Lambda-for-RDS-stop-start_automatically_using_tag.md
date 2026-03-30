# How_to_Schedule_Lambda-for-RDS-stop-start_automatically_using_tag
### 1. Apply the following tag to RDS instance / cluster.
- Please add below tag to all RDS instances / cluster .
  - Key = AutoRestart
  - Value = True

### 2. Create Lamdba Role.
- 2.1. Create Custom Policy
   1. Open **IAM** --> Click **Policies**
   2. Click **Create Policies**
   3. Select JSON --> Add Following Custom Policies
      - [rds_stop_start_policy](https://github.com/mevasaroj/CLOUD/blob/main/AWS/Maintenance/rds_stop_start_policy.json)
   
   4. Click Next
   
   5. Under **Review and create**
        - Policy name = **rds_stop_start_policy**
        - Description - optional = Type Description
        - Add tags - optional = Type the require tags

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
       - Description = Default
        - Step 1: Select trusted entities = No Change
        - Step 2: Add permissions = No Change
        - Step 3: Add tags = Add require tags

     6. Click Create Role
   

### 3. Create 2 Lamdba Function.
#### 3.1. To stop the RDS instance / cluster
##### 3.1.1. Create Lamdba Function - To Stop RDS
   ```hcl
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **rds_stop_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **rds_stop_start_role**

   4. Click Create Function
   ```

##### 3.1.2. Update Lamdba Function Code as below - To Stop RDS
 - To Stop **RDS Cluster**
    ```hcl
    import boto3

    # Initialize RDS client
    rds = boto3.client('rds')

    def lambda_handler(event, context):
       # Describe all DB clusters
       clusters = rds.describe_db_clusters()
    
       for cluster in clusters['DBClusters']:
           cluster_id = cluster['DBClusterIdentifier']
           cluster_arn = cluster['DBClusterArn']
           cluster_status = cluster['Status']
        
        # Check if DB cluster is available
        if cluster_status == 'available':
            try:
                # Retrieve tags for the cluster
                tags = rds.list_tags_for_resource(ResourceName=cluster_arn)['TagList']
                
                # Check for the 'autostop' tag
                should_stop = any(tag['Key'] == 'AutoRestart' and tag['Value'] == 'True' for tag in tags)
                
                if should_stop:
                    # Stop the DB cluster
                    result = rds.stop_db_cluster(DBClusterIdentifier=cluster_id)
                    print(f"Stopping cluster: {cluster_id}.")
                    
            except Exception as e:
                print(f"Cannot stop cluster {cluster_id}.")
                print(e)

    if __name__ == "__main__":
    lambda_handler(None, None)
    ```
    
 - To Stop **RDS Instance**
   ```hcl
   import boto3
   rds = boto3.client('rds')
   
   def lambda_handler(event, context):
      #Stop DB instances
      dbs = rds.describe_db_instances()
      for db in dbs['DBInstances']:
        #Check if DB instance is not already stopped
        if (db['DBInstanceStatus'] == 'available'):
            try:
                GetTags=rds.list_tags_for_resource(ResourceName=db['DBInstanceArn'])['TagList']
                for tags in GetTags:
                #if tag "autostop=yes" is set for instance, stop it
                    if(tags['Key'] == 'AutoRestart' and tags['Value'] == 'True'):
                        result = rds.stop_db_instance(DBInstanceIdentifier=db['DBInstanceIdentifier'])
                        print ("Stopping instance: {0}.".format(db['DBInstanceIdentifier']))
            except Exception as e:
                print ("Cannot stop instance {0}.".format(db['DBInstanceIdentifier']))
                print(e)
                
    if __name__ == "__main__":
    lambda_handler(None, None)
   ```
 

##### 3.2. To start the RDS instance / cluster
##### 3.2.1. Create Lamdba Function - To Start RDS
   ```hcl
   1. Open **AWS Console** --> Type **Lambda** in Search --> Click on **Lambda** to Open Dashboard
   2. Click **Function** --> Click **Create function**
   3. Under Create function
       - Choose one of the following options to create your function. = **Author from scratch**
       - Function name = **rds_start_lambda_function**
       - Runtime = **Python 3.14**
       - Architecture = **x86_64**
       - Change default execution role = Select **Use another role** --> Browse the Lambda Role Name **rds_stop_start_role**

   4. Click Create Function
   ```

##### 3.2.2. Update Lamdba Function Code as below - To Start RDS
 - To Start **RDS Cluster**
   ```hcl
   import boto3

   # Initialize RDS client
   rds = boto3.client('rds')

   def lambda_handler(event, context):
    # Describe all DB clusters
    clusters = rds.describe_db_clusters()
    
    for cluster in clusters['DBClusters']:
        cluster_id = cluster['DBClusterIdentifier']
        cluster_arn = cluster['DBClusterArn']
        cluster_status = cluster['Status']
        
        # Check if DB cluster is stopped
        if cluster_status == 'stopped':
            try:
                # Retrieve tags for the cluster
                tags = rds.list_tags_for_resource(ResourceName=cluster_arn)['TagList']
                
                # Check for the 'autostart' tag
                should_start = any(tag['Key'] == 'AutoRestart' and tag['Value'] == 'True' for tag in tags)
                
                if should_start:
                    # Start the DB cluster
                    result = rds.start_db_cluster(DBClusterIdentifier=cluster_id)
                    print(f"Starting cluster: {cluster_id}.")
                    
            except Exception as e:
                print(f"Cannot start cluster {cluster_id}.")
                print(e)

    if __name__ == "__main__":
    lambda_handler(None, None)
   ```

 - To Start **RDS Instance**
   ```hcl
   def lambda_handler(event, context):

    #Start DB Instances
    dbs = rds.describe_db_instances()
    for db in dbs['DBInstances']:
        #Check if DB instance stopped. Start it if eligible.
        if (db['DBInstanceStatus'] == 'stopped'):
            try:
                GetTags=rds.list_tags_for_resource(ResourceName=db['DBInstanceArn'])['TagList']
                for tags in GetTags:
                #if tag "autostart=yes" is set for instance, start it
                    if(tags['Key'] == 'AutoRestart' and tags['Value'] == 'True'):
                        result = rds.start_db_instance(DBInstanceIdentifier=db['DBInstanceIdentifier'])
                        print ("Starting instance: {0}.".format(db['DBInstanceIdentifier']))
            except Exception as e:
                print ("Cannot start instance {0}.".format(db['DBInstanceIdentifier']))
                print(e)

    if __name__ == "__main__":
    lambda_handler(None, None)

   ```


