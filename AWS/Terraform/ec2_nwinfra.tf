##################################################################################################################################################
########### REMOTE VPC, SUBNET and SECURITY GROUP VALUES DECLARATION     ##############################################
##################################################################################################################################################

##################################################################################################################################################
########### 01.START OF HBL-AWS-APS1-VKYC-NONPCIDSS-PROD-TURN-EC2-01     ##############################################
##################################################################################################################################################
module "hbl-aws-aps1-vkyc-nonpcidss-prod-turn-ec2-01" {
  source                  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ec2"
  providers = { aws = aws.nwinfra }
  name                    = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "turn-ec2"])
  subnet_id               = var.nwinfra-inbound-media-prod-stun-turn-subnet-aza
  vpc_security_group_ids  = ["${var.nwinfra-media-inbound-turn-server-sg}", "${var.nwinfra-inbound-media-prod-CommonInfraRule-sg}"]
  ami                     = "ami-0c09c3157117eaff2"     #Golden Image RHEL 
  #ami = "ami-022ce6f32988af5fa"  #Mkt Place AMI
  instance_type           = "c6a.large"
  key_name                = "hbl-aws-aps1-nwinfra-inbound-media-prod-vkyc-kp"
  metadata_options        = var.metadata_options
  monitoring              = false
  disable_api_termination = true
  enable_volume_tags      = true
 # iam_instance_profile    = "hbl-aws-nwinfra-ssm-ec2care-role"
  private_ip              = "10.199.92.203"
  volume_tags = merge(
    {
      application = "turn-ec2"
    }, 
    var.additional_tags
  )
  tags = merge(
    {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "turn-ec2"])
    }, 
    var.additional_tags
  )
}

module "hbl-aws-aps1-vkyc-nonpcidss-prod-turn-ec2-01_ebs_01" {
  source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ebs"
  providers = { aws = aws.nwinfra }
  depends_on = [module.hbl-aws-aps1-vkyc-nonpcidss-prod-turn-ec2-01]

  availability_zone = local.subnet_az_map.az_1
  size              = 50
  device_name = "/dev/sdg"
  instance_id = module.hbl-aws-aps1-vkyc-nonpcidss-prod-turn-ec2-01.id
  #kms_key_id = var.kms_key_id
  tags = merge(
    {
      application = "turn-ec2",
    }, 
    var.additional_tags,
  )
}
##################################################################################################################################################
########### 01.START OF HBL-AWS-APS1-VKYC-NONPCIDSS-PROD-TURN-EC2-01    ##############################################
##################################################################################################################################################
  
  ##################################################################################################################################################
########### REMOTE VPC, SUBNET and SECURITY GROUP VALUES DECLARATION     ##############################################
##################################################################################################################################################

##################################################################################################################################################
########### 01.START OF HBL-AWS-APS1-VKYC-NONPCIDSS-PROD-TURN-EC2-02     ##############################################
##################################################################################################################################################
module "hbl-aws-aps1-vkyc-nonpcidss-prod-turn-ec2-02" {
  source                  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ec2"
  providers = { aws = aws.nwinfra }
  name                    = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "turn-ec2-02"])
  subnet_id               = var.nwinfra-inbound-media-prod-stun-turn-subnet-azb
  vpc_security_group_ids  = ["${var.nwinfra-media-inbound-turn-server-sg}", "${var.nwinfra-inbound-media-prod-CommonInfraRule-sg}"]
  ami                     = "ami-035e3b84134467696"     # Turn Server AMI Available in NWINFRA Account 
  #ami = "ami-022ce6f32988af5fa"  #Mkt Place AMI
  instance_type           = "c6a.large"
  key_name                = "hbl-aws-aps1-nwinfra-inbound-media-prod-vkyc-kp"
  metadata_options        = var.metadata_options
  monitoring              = false
  disable_api_termination = true
  enable_volume_tags      = true
  #iam_instance_profile    = "hbl-aws-nwinfra-ssm-ec2care-role"
  private_ip              = "10.199.92.214"
  volume_tags = merge(
    {
      application = "turn-ec2-02"
    }, 
    var.additional_tags
  )
  tags = merge(
    {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "turn-ec2-02"])
    }, 
    var.additional_tags
  )
}
##################################################################################################################################################
########### 01.START OF HBL-AWS-APS1-VKYC-NONPCIDSS-PROD-TURN-EC2-02    ##############################################
##################################################################################################################################################
module "turn-ec2-03" {
  source                  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ec2"
  providers = { aws = aws.nwinfra }
  name                    = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "turn-ec2-03"])
  subnet_id               = var.nwinfra-inbound-media-prod-stun-turn-subnet-azc
  vpc_security_group_ids  = ["${var.nwinfra-media-inbound-turn-server-sg}", "${var.nwinfra-inbound-media-prod-CommonInfraRule-sg}"]
  ami                     = "ami-0bbd071d9dd3e1af0"     # Turn Server AMI Available in NWINFRA Account 
  instance_type           = "c6a.large"
  key_name                = "hbl-aws-aps1-nwinfra-inbound-media-prod-vkyc-kp"
  metadata_options        = var.metadata_options
  monitoring              = false
  disable_api_termination = true
  enable_volume_tags      = true
  #iam_instance_profile    = "hbl-aws-nwinfra-ssm-ec2care-role"
 # private_ip              = "10.199.92.214"
  volume_tags = merge(
    { application = "turn-ec2-03"
    },  var.additional_tags)
  tags = merge(
    {  Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "turn-ec2-03"])
    }, var.additional_tags )
}
##################################################################################################################################################
  module "turn-ec2-04" {
  source                  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ec2"
  providers = { aws = aws.nwinfra }
  name                    = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env,  "turn-ec2-04"])
  subnet_id               = var.nwinfra-inbound-media-prod-stun-turn-subnet-aza
  vpc_security_group_ids  = ["${var.nwinfra-media-inbound-turn-server-sg}", "${var.nwinfra-inbound-media-prod-CommonInfraRule-sg}"]
  ami                     = "ami-0bbd071d9dd3e1af0"     # Turn Server AMI Available in NWINFRA Account 
  instance_type           = "c6a.large"
  key_name                = "hbl-aws-aps1-nwinfra-inbound-media-prod-vkyc-kp"
  metadata_options        = var.metadata_options
  monitoring              = false
  disable_api_termination = true
  enable_volume_tags      = true
  #iam_instance_profile    = "hbl-aws-nwinfra-ssm-ec2care-role"
 # private_ip              = "10.199.92.214"
  volume_tags = merge(
    { application = "turn-ec2-03"
    },  var.additional_tags)
  tags = merge(
    {  Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "turn-ec2-04"])
    }, var.additional_tags )
}
##################################################################################################################################################
