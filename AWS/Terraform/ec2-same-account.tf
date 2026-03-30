#---------------------------------------------------------------------------
module "app_ec2" {
  source                 = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ec2_v6"
  name                   = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "rhel9-ec2"])
  ami                    = "ami-0ab06e49ceb07194f"
  instance_type          = "c6a.large"
  #key_name               = "goldenimage_key1"
  monitoring             = false
  create_security_group = false
  vpc_security_group_ids = ["${var.infra-sg}", "${var.nonpcidss-CommonInfraRule-sg}"]
  subnet_id              = var.infra-subnet-azc
  #private_ip              = "10.211.212.80"
  #iam_instance_profile   = "hbl-aws-aps1-appname-uat-terraform-role"


  metadata_options       = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit =  2
    instance_metadata_tags      = "enabled"
  }

volume_tags = merge({ application = "jenkins-ec2" }, 
    var.additional_tags )
  
  tags = merge(
    { Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "app-ec2"])}",
    ProvisioningDate = "10-July-2025", 
    application = "app"}, 
    var.additional_tags)
    
 }
 
#---------------------------------------------------------------------------
# EBS VOLUME GNG TW BRE INSTANCE 01
module "app_ec2_01-ebs_01" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ebs"
  depends_on = [module.app_ec2]
  availability_zone = local.subnet_az_map.az_3
  size              = 30
  device_name = "/dev/sdg"
  instance_id = module.app_ec2.id
  kms_key_id = var.kms_key_id
  tags = merge({ application = "app"}, 
   var.additional_tags,)
}  
#---------------------------------------------------------------------------
