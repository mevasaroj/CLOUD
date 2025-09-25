resource "aws_memorydb_subnet_group" "valkey_subnet" {
  name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "valkey-subnet-group"])
  description = "Subnet group for MemoryDB cluster"
  subnet_ids  = ["${var.db-subnet-aza}", "${var.db-subnet-azb}", "${var.db-subnet-azc}"]
  tags = merge(
    { Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "valkey-subnet-group"])}"
    }, var.additional_tags)
}
#=================================================================================================
module "module_aws-memory-db-v6" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-memory-db-v6"
  version = "1.3.3"
  name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "valkey-db"])
  
  engine                     = "valkey"
  engine_version             = "7.2"
  auto_minor_version_upgrade = true
  node_type                  = "db.r6gd.xlarge"
  num_shards                 = 2
  num_replicas_per_shard     = 2
  data_tiering               = true
  
  tls_enabled              = true
  security_group_ids       = ["${var.mysql-sg}", "${var.nonpcidss-CommonInfraRule-sg}"]
  maintenance_window       = "sun:23:00-mon:01:30"
  #sns_topic_arn            = aws_sns_topic.valkey.arn
  snapshot_retention_limit = 7
  snapshot_window          = "05:00-09:00"
  
  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      type          = "iam"
      tags          = { user = "admin" }
    }
/*
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = "[password.hdfcbank123$]"
      tags          = { user = "readonly" }
    }
*/
  }
  
  # Parameter group
  parameter_group_name        = join("-", [local.org, local.csp, local.region, local.account, local.env, "param-group"])
  parameter_group_description = "Valkey MemoryDB parameter group"
  parameter_group_family      = "memorydb_valkey7"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    parameter_group = "custom"
  }
  
  # Subnet group
  create_subnet_group = false
  #subnet_ids     = ["${var.db-subnet-aza}", "${var.db-subnet-azb}", "${var.db-subnet-azc}"]
  subnet_group_name  = aws_memorydb_subnet_group.valkey_subnet.name
  
  
  tags = merge(
    { Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "valkey-db"])}"
    }, var.additional_tags)
  
  
}
