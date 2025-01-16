#=======================================================================================================================================================================
module "trx-loader-database" {
  source = "cloudposse/glue/aws//modules/glue-catalog-database"

  catalog_database_name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-database"])
  catalog_database_description = "Glue Catalog database"
  location_uri                 = format("s3://s3-bucket/dc-loader-job/")  # Replace script location for database

  attributes = ["payments"]
  
  tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "trx-loader-database"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
}
    
module "trx-loader-table" {
  source = "cloudposse/glue/aws//modules/glue-catalog-table"

  catalog_table_name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-table"])
  catalog_table_description = "Glue Catalog table"
  database_name             = module.trx-loader-database.name

  storage_descriptor = {
    #Physical location of the table
    #location = local.data_source
    location = format("s3://s3-bucket/dc-loader-job/")    # Replace table storage location
  }

  tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "glue_catalog_table"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
 }


resource "aws_glue_security_configuration" "trx-loader-security-configuration" {
  name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "trx-loader-security-configuration"])

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = "DISABLED"
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = "DISABLED"
    }

    s3_encryption {
      kms_key_arn        = "arn:aws:kms:ap-south-1:xxxxxxxxxxxx:key/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Replace KMS KEy ARN
      s3_encryption_mode = "SSE-KMS"
    }
  }
}


module "glue_connection_jdbc" {
  source = "cloudposse/glue/aws//modules/glue-connection"

  connection_name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "glue_connection_jdbc"])
  connection_description = "Glue connection to Postgres database"
  connection_type        = "JDBC"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://postgresql-instance-01.cd3tllazsuy5.ap-south-1.rds.amazonaws.com:5433/recon" # Replace RDS Instance ARN:Port-Number/Table-name
    SECRET_ID           = "trx-metadata-postgres" # Replace Secret ID for RDS Connection
    JDBC_ENFORCE_SSL    = "true"
  }

  physical_connection_requirements = {
    # List of security group IDs used by the connection
    security_group_id_list = ["${var.eks-cluster-workernode-sg}" ]
    # The availability zone of the connection. This field is redundant and implied by subnet_id, but is currently an API requirement
    availability_zone = local.subnet_az_map.az_1
    # The subnet ID used by the connection
    subnet_id = var.infra-subnet-aza
  }
  tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "glue_connection_jdbc"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
}


module "glue_connection_network" {
  source = "cloudposse/glue/aws//modules/glue-connection"

  connection_name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "glue_connection_network"])
  connection_description = "Glue connection to Postgres database"
  connection_type        = "NETWORK"
  connection_properties  = {
      JDBC_ENFORCE_SSL    = "true"
  }

  physical_connection_requirements = {
    # List of security group IDs used by the connection
    security_group_id_list = ["${var.eks-cluster-workernode-sg}" ]
    # The availability zone of the connection. This field is redundant and implied by subnet_id, but is currently an API requirement
    availability_zone = local.subnet_az_map.az_1
    # The subnet ID used by the connection
    subnet_id = var.infra-subnet-aza
  }
  tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "glue_connection_network"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
}


module "trx-loader-glue" {
  source = "cloudposse/glue/aws//modules//aws-glue/modules/glue-job"


  job_name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-glue"])
  job_description   = "Glue Job that runs data_cleaning.py Python script"
  connections       = ["${module.glue_connection_jdbc.name}", "${module.glue_connection_network.name}"]
  role_arn          = "arn:aws:iam::xxxxxxxxxxxx:role/glue-job-role"  # Replace the Role ARN
  security_configuration = aws_glue_security_configuration.trx-loader-security-configuration.name
  glue_version      = "4.0"
  worker_type       = "G.2X"
  #max_capacity      = 10
  number_of_workers = 2
  max_retries       = 0  
  timeout = 30 # The job timeout in minutes

 execution_property = {
    max_concurrent_runs = 10
  }

  command = {
    # The name of the job command. Defaults to `glueetl`.
    # Use `pythonshell` for Python Shell Job Type, or `gluestreaming` for Streaming Job Type.
    #name            = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-glue"])
    name = "glueetl"
    script_location = format("s3://s3-bucket/dc-loader-job/dir-dc-loader-core.scala")  # Replace script location
    python_version  = 3
  }

  default_arguments = {
    "--job-language"                          = "scala"
    "--job-bookmark-option"                   = "job-bookmark-disable"
    "--enable-s3-parquet-optimized-committer" = true
    "--enable-rename-algorithm-v2"            = false
    "--enable-glue-datacatalog"               = false
    "--enable-metrics"                        = true
    "--enable-continuous-cloudwatch-log"      = true
    "--enable-continuous-log-filter"          = true
    "--enable-spark-ui"                       = true
    "--enable-auto-scaling"                   = true
    "--spark-event-logs-path"                 = "s3://s3-bucket/Spark_UI_Logs/BATCH_JOB/" # Replace log location
    "--user-jars-first"       = true
  }
  
  tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "trx-loader-glue"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
  
}

 module "trx-loader-workflow" {
  source = "cloudposse/glue/aws//modules//glue-workflow" 
  workflow_name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-workflow"])

  workflow_description = "trx-loader"
  max_concurrent_runs  = 2

 tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "trx-loader-workflow"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)
   
}
    
module "trx-loader-trigger" {
  source = "cloudposse/glue/aws//modules/glue-trigger"

  trigger_name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "trx-loader-trigger"])

  workflow_name       = module.trx-loader-workflow.name
  trigger_enabled     = true
  start_on_creation   = true
  trigger_description = "Glue Trigger that triggers a Glue Job on a schedule"
  schedule            = "cron(15 12 * * ? *)"
  type                = "SCHEDULED"

  actions = [
    {
      job_name = module.trx-loader-glue.name
      # The job run timeout in minutes. It overrides the timeout value of the job
      timeout = 10
    }
  ]
 
 tags = merge( {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "trx-loader-trigger"]),
      ProvisioningDate = "05-Dec-2024"
    }, var.additional_tags)

}

#=======================================================================================================================================================================    
