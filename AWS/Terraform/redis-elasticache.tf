##################################################################################################################################################
########### 01.START OF HBL-AWS-APS1-REDIS-01     ##############################################
##################################################################################################################################################
module "redis-elasticache-01" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-elasticache-master"
  
  cluster_id               = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "redis-01"])
  create_cluster           = true
  create_replication_group = false
    
  vpc_id                           = var.nonpcidss-vpc
  create_security_group            = false
  node_type                        = "cache.m6g.large"
  security_group_ids               = ["${var.elasticsearch-sg}", "${var.nonpcidss-CommonInfraRule-sg}"]
  subnet_ids                       = ["${var.db-subnet-aza}", "${var.db-subnet-azb}", "${var.db-subnet-azc}"]
  automatic_failover_enabled       = true
  cluster_mode_enabled             = true
  multi_az_enabled                 = true
  apply_immediately                = true
  engine_version                   = "7.0"
  at_rest_encryption_enabled       = true
  transit_encryption_enabled       = true
  #kms_key_id                       = "arn:aws:kms:ap-south-1:911372318716:key/mrk-5be92cb54bd64cb48a44b0ee85904285"
  auto_minor_version_upgrade       = false
  snapshot_window                  = "02:30-03:30"
  snapshot_retention_limit         = 7 
  description                      = "Elasticache for Application"
  maintenance_window               = "sun:01:00-sun:02:00"
  create_parameter_group = false
  tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.account, local.env, "redis-01"])}"}, 
    var.additional_tags)
}

##################################################################################################################################################
########### 01.END OF HBL-AWS-APS1-REDIS-01    ##############################################
##################################################################################################################################################
