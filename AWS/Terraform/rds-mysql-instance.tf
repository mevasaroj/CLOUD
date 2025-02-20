##################################################################################################################################################
########### START OF COMMON DB's GROUP     ##############################################
##################################################################################################################################################
#====================== COMMON DB SUBNET GROUP ==============================================================================================
#============================================================================================================================================
module "mysql-subnet-group" {
  source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-rds/modules/db_subnet_group"
  name  = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-subnet-group"])
  subnet_ids = ["${var.db-subnet-aza}", "${var.db-subnet-azb}", "${var.db-subnet-azc}"]
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-subnet-group"]), 
         ProvisioningDate = "10-Jan-2025"}, var.additional_tags )
}
#============================================================================================================================================
#====================== COMMON DB PARAMETER GROUP ===========================================================================================
#============================================================================================================================================
module "mysql-parameter-group" {
  source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-rds/modules/db_parameter_group"
  create = true
  name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-parameter-group"])
  description     = "mysql instance parameter group"
  family          = "mysql8.0"
   

  parameters = [
    { name  = "local_infile", value = "0" , apply_method = "immediate" }, 
    { name = "password_history", value = "5", apply_method = "immediate"  },
    { name = "password_reuse_interval", value = "365", apply_method = "immediate"  },
    { name = "require_secure_transport", value = "1", apply_method = "immediate"  }
  ]  

    
  tags = merge(
    { Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-parameter-group"])}",
    ProvisioningDate = "10-Jan-2025"}, var.additional_tags)
}
#=================================================================================================================================================
########### END OF COMMON DB's GROUP     ##############################################
##################################################################################################################################################
########### START OF DB INSTNACE CREATION - 01    ##############################################
#=================================================================================================================================================
module "mysql-instance" {
  source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-rds"
  identifier = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-instance"])

  # Engine and Family
  engine               = "mysql"
  major_engine_version = "8"
  family               = "mysql8.0"
  engine_version       = "8.0.40"
  instance_class       = "db.r6g.large"
  deletion_protection  = true
  
  #Storage
  allocated_storage     = 20
  max_allocated_storage = 500
  storage_type          = "gp3"
  storage_encrypted     = true
  kms_key_id            = "arn:aws:kms:ap-south-1:911372318716:key/mrk-0c167f6f2bf641aba0b4490697e08795"
  
  #DBName, Username , Passwor dna Port
  db_name               = "mysqldb"
  username              = "hdfcbank"
  password              = "hdfcbank123$"
  port                  = "3356"
  iam_database_authentication_enabled = true
  #custom_iam_instance_profile = "arn:aws:iam::593793066189:role/hbl-aws-cam-role-tfe-dlm-uat"

  # VPC, Security Group and Subnet
  vpc_security_group_ids = ["${var.mysql-sg}", "${var.nonpcidss-CommonInfraRule-sg}"]
  create_db_option_group = false
  db_subnet_group_name = module.mysql-subnet-group.db_subnet_group_id
   
  # Parameter Group
  create_db_parameter_group = false
  parameter_group_name = module.mysql-parameter-group.db_parameter_group_id
  
  # AZ's & Public Accesible
  multi_az = true
  publicly_accessible = false
  
  # Version upgrade
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  apply_immediately           = true
  blue_green_update           = { enabled = false }
  
  #Backup and Maintenace
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  backup_retention_period         = 7

  # Cloudwatch Log Group
  create_cloudwatch_log_group = false
  enabled_cloudwatch_logs_exports = ["general", "audit", "error", "slowquery"]
  
  copy_tags_to_snapshot = true
  skip_final_snapshot   = true

  performance_insights_enabled          = false
  performance_insights_retention_period = 7

  monitoring_interval             = "0"
  monitoring_role_name            = "rds-monitoring-role"
  monitoring_role_use_name_prefix = false
  create_monitoring_role          = false
    
    tags = merge(
    { Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "mysql-instance"])}",
    ProvisioningDate = "10-Jan-2025"}, var.additional_tags)
}

#=================================================================================================================================================
########### END OF DB INSTNACE CREATION  ##############################################
##################################################################################################################################################
