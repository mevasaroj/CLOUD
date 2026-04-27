###################################################################################################################
############# IAM POLICY for GATEWAY ENDPOINT ####################
#==================================================================================================================
data "aws_iam_policy_document" "endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"

      values = ["arn:aws:iam::*:role/storage-access-role-prod-ap-south-1",
                "arn:aws:iam::*"]
    }
  }
}
#========================================================================================================================
############# END IAM POLICY for GATEWAY ENDPOINT ####################
###########################################################################################################################
############# START VPC ENDPOINT ####################
#========================================================================================================================
module "g3-gateway-endpoint" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = var.nonpcidss-prod-vpc
  create_security_group = false
  security_group_ids = ["${var.vpc-endpoints-sg}" ]
  subnet_ids         = ["${var.infra-subnet-aza}", "${var.infra-subnet-azb}", "${var.infra-subnet-azc}"]

  endpoints = {
    #-------------------------------------------------
    # START = for Gateway -  Endpoints
    #-------------------------------------------------
    # Gateway endpoint
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = ["rtb-0c051b6bbdaab04b7"]
      policy = data.aws_iam_policy_document.gateway.json
	  tags  = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "s3-gateway-endpoint"]) }
    },
	#-------------------------------------------------
    # END = for Gatway -  Endpoints
    #-------------------------------------------------
  }
 tags = merge( var.additional_tags)  
}


####################################################################################################################################
################# OR BELOW TFE CODE Can Be Use#####################################################################
####################################################################################################################################

module "g3-gateway-endpoint" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = var.nonpcidss-prod-vpc
  create_security_group = false
  security_group_ids = ["${var.vpc-endpoints-sg}" ]
  subnet_ids         = ["${var.infra-subnet-aza}", "${var.infra-subnet-azb}", "${var.infra-subnet-azc}"]

  endpoints = {
    #-------------------------------------------------
    # START = for Gateway -  Endpoints
    #-------------------------------------------------
    # Gateway endpoint
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = ["rtb-0c051b6bbdaab04b7"]

      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
        {
           "Sid" : "Allow",
           "Effect" : "Allow",
           "Principal" : {
             "AWS" : [
		  "arn:aws:iam::xxxxxxxxxxxx:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS",
		  "arn:aws:iam::xxxxxxxxxxxx:role/secrete-manager-prod",
		  "arn:aws:iam::xxxxxxxxxxxx:role/tfe-prod",
		  "arn:aws:iam::xxxxxxxxxxxx:role/eks-cluster-prod",
		  "arn:aws:iam::xxxxxxxxxxxx:role/eks-workernode-prod"
		  ]
           },
        "Action" : "*",
        "Resource" : "*"
       }
     ]
    })


   tags  = { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "s3-gateway-endpoint"]) }
    },

    #-------------------------------------------------
    # END  Gateway -  Endpoints
    #-------------------------------------------------

  }
 tags = merge( var.additional_tags)  
}
#========================================================================================================================
############# END VPC ENDPOINT ####################
##########################################################################################################################
