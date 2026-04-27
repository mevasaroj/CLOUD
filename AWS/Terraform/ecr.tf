################################################################################
# START ECR Repository
################################################################################

module "ecr" {
  source = "../modules/aws-ecr"

  repository_name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ecr-repo"])
  

  repository_read_write_access_arns = ["arn:aws:iam::273354645607:role/hbl-aws-role-tfeappinfra-genai-dev"]

  create_lifecycle_policy           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true

  tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ecr-repo"])}",
	  ProvisioningDate = "18-April-2025"}, 
      var.additional_tags)
	
}


################################################################################
# END ECR Registry
################################################################################
