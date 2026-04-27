################################################################################
# START MSK KAFKA Resources
################################################################################

module "msk-serverless-cluster" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-msk-kafka-cluster/modules/serverless"

  name  = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "msk-serverless-cluster"])

  security_group_ids = [var.postgresql-sg]
  subnet_ids         = ["${var.mysql-subnet-aza}", "${var.mysql-subnet-azb}", "${var.mysql-subnet-azc}"]

  create_cluster_policy = false

  tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "msk-serverless-cluster"])}",
	  ProvisioningDate = "18-April-2025"}, 
      var.additional_tags)
	  
}

################################################################################
# END MSK KAFKA Resources
################################################################################
