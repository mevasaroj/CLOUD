module "elasticache_valkey" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-elasticache-v6"

  replication_group_id = join("-", [local.org, local.csp, local.region, local.account, local.env, "valkey"])

  engine         = "valkey"
  engine_version = "7.2"
  node_type      = "cache.t4g.small"

  transit_encryption_enabled = true
  auth_token                 = "PickSomethingMoreSecure123!"
  maintenance_window         = "sun:05:00-sun:09:00"
  apply_immediately          = true

  # Security Group
  vpc_id = var.nonpcidss-prod-vpc
  create_security_group = false
  security_group_name = var.elasticache-sg

  # Subnet Group
  create_subnet_group = false
  #subnet_group_name        = join("-", [local.org, local.csp, local.region, local.account, local.env, "valkey_subnet_group"])
  #subnet_group_description = "Valkey replication group subnet group"
  subnet_group_name   = var.infra-subnet-aza

  # Parameter Group
  create_parameter_group      = true
  parameter_group_name        = "valkey"
  parameter_group_family      = "valkey7"
  parameter_group_description = "Valkey replication group parameter group"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "valkey"])
    } )
}
