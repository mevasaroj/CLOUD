module "elasticache_valkey" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-elasticache-v6"

  replication_group_id = join("-", [local.org, local.csp, local.region, local.account, local.env, "valkey"])

  engine         = "valkey"
  engine_version = "7.2"
  node_type      = "cache.t2.medium"

  transit_encryption_enabled = true
  kms_key_arn = "arn:aws:kms:ap-south-1:911372318716:key/mrk-d77d91e1dca246c6a8d534a2b48b3e39"
  auth_token                 = "HdfcBankLimited123$"

  maintenance_window         = "sun:01:00-sun:04:00"
  apply_immediately          = true

  # Security Group
  vpc_id = var.ee-nonpcidss-vpc
  create_security_group = false
  security_group_name = "sg-0c2c865bc29bbd47f"
  
# Subnet Group
  create_subnet_group = true
  subnet_group_name   = join("-", [local.org, local.csp, local.region, local.account, local.env, "valkey-subnet"])
  subnet_ids = ["${var.infra-subnet-aza}", "${var.infra-subnet-azb}", "${var.infra-subnet-azc}"]

  # Parameter Group
  create_parameter_group      = false
  
# Muti-AZ
  multi_az_enabled = true
  automatic_failover_enabled = true
  num_cache_nodes = 2
  preferred_availability_zones = ["ap-south-1a","ap-south-1b","ap-south-1c"]

# Backup
  snapshot_retention_limit = 7
  snapshot_window  = "05:00-06:00"
  
tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "valkey"])
    } )
}
