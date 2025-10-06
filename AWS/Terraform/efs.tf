
module "efs" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-efs"

  # File system
  name           = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "efs"])
  #creation_token = "example-token"
  encrypted      = true
  kms_key_arn    = "arn:aws:kms:ap-south-1:911372318716:key/3226efbd-778f-4e56-be5d-e777a438c733"

  performance_mode                = "maxIO"
  throughput_mode                 = "provisioned"
  provisioned_throughput_in_mibps = 256

  # Mount targets / security group
  mount_targets = {
    "ap-south-1a" = {
      subnet_id = "subnet-0a3150338ceb4949a" # Workernode Subnet
      security_groups = [ "sg-0c4873f15f430d033" ]  # Workernode SG - 2049 allowed from VPC CIDR 10.x & 100.x Both
    }
    "ap-south-1b" = {
      subnet_id = "subnet-015cf7b6567ac7d26" # Workernode Subnet
      security_groups = [ "sg-0c4873f15f430d033" ]  # Workernode SG - 2049 allowed from VPC CIDR 10.x & 100.x Both
    }
    "ap-south-1c" = {
      subnet_id = "subnet-073ef23dca7903e6a" # Workernode Subnet
      security_groups = [ "sg-0c4873f15f430d033" ]  # Workernode SG - 2049 allowed from VPC CIDR 10.x & 100.x Both
    }
  }
  
# Security Group Information
  create_security_group = false
  #security_group_name = "sg-0c4873f15f430d033"  # Workernode SG - 2049 allowed from VPC CIDR 10.x & 100.x Both

 # Access point(s)
  access_points = {
    data-fs = {
      name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "data-fs"])
      path = "/data"
      posix_user = {
        gid            = 1001
        uid            = 1001
        permissions    = "755"
       }
     tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "data-fs"]),
      ProvisioningDate = "23-Oct-2024" }, var.additional_tags  )
   } 
  }

  # Backup policy
  enable_backup_policy = true

 # EFS Policy
  attach_policy = true
  bypass_policy_lockout_safety_check = false
  policy_statements = [
    {
      sid     = "EFS-Allow"
      actions = [
           "elasticfilesystem:ClientRootAccess",
           "elasticfilesystem:ClientWrite",
           "elasticfilesystem:ClientMount"
        ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
    }
  ]
	
	
  #EFS TAG
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "efs"]),
      ProvisioningDate = "23-Oct-2024" }, var.additional_tags  )
}
