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
