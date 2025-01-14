#####################################################################################################################################
data "aws_iam_policy_document" "gateway" {
  statement {
    sid = "AllowIAM"
    actions = [ "*", ]
    resources = [ "*", ]
	principals {
         type = "AWS"
         identifiers = [
	    "arn:aws:iam::686255955923:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS",
		"arn:aws:iam::686255955923:role/hbl-aws-cam-role-secrete-manager-dlm-prod",
		"arn:aws:iam::686255955923:role/hbl-aws-cam-role-tfe-dlm-prod",
		"arn:aws:iam::686255955923:role/hbl-aws-cam-role-eks-cluster-dlm-prod",
		"arn:aws:iam::686255955923:role/hbl-aws-cam-role-eks-workernode-dlm-prod"
	  ]
    }
  }
}

module "prod-endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = var.nonpcidss-prod-vpc
  create_security_group = false
  security_group_ids = ["${var.vpc-endpoints-sg}" ]
  subnet_ids         = ["${var.infra-subnet-aza}", "${var.infra-subnet-azb}", "${var.infra-subnet-azc}"]

  endpoints = {
    #-------------------------------------------------
    # START = for EKS Cluster -  Endpoints
    #-------------------------------------------------
    # Gateway endpoint
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = ["rtb-0c051b6bbdaab04b7"]
      policy = data.aws_iam_policy_document.gateway.json
      tags  = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "s3-gateway-endpoint"]) }
    },
    # interface endpoint
    ec2 = {
      service = "ec2"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ec2-endpoint"]) }
    },
    ecr-api = {
      service = "ecr.api"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ecr-api-endpoint"]) }
    },
    ecr-dkr = {
      service = "ecr.dkr"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ecr-dkr-endpoint"]) }
    },
    sts = {
      service = "sts"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "sts-endpoint"]) }
    },
    eks = {
      service = "eks"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "eks-endpoint"]) }
    },
    eks-auth = {
      service = "eks-auth"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "eks-auth-endpoint"]) }
    },
    #-------------------------------------------------
    # END = for EKS Cluster-  Endpoints
    #-------------------------------------------------
    rds = {
      service = "rds"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "rds-endpoint"]) }
    },
 
    # START - SSM Manager Endpoints
    #-------------------------------------------------
    ec2messages = {
      service = "ec2messages"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ec2messages-endpoint"]) }
    },    
    ssm = {
      service = "ssm"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ssm-endpoint"]) }
    },    
    ssmmessages = {
      service = "ssmmessages"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ssmmessages-endpoint"]) }
    },    
    #-------------------------------------------------
    # END - SSM Manager Endpoints
    #-------------------------------------------------

    # START - For Private Load Balancer
    #-------------------------------------------------
    elasticloadbalancing = {
      service = "elasticloadbalancing"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "elasticloadbalancing-endpoint"]) }
    },
    acm-pca = {
      service = "acm-pca"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "acm-pca-endpoint"]) }
    },
    #-------------------------------------------------
    # End for Private Load Balancer
    #-------------------------------------------------
    # START  for Secret Manager
    #-------------------------------------------------
    secretsmanager = {
      service = "secretsmanager"
      private_dns_enabled = true
      tags    = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "secretsmanager-endpoint"]) }
    },
    #-------------------------------------------------
    # END  for Secret Manager
    #-------------------------------------------------

  }
 tags = merge( var.additional_tags)  
}
#####################################################################################################################################
