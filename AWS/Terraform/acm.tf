######################################################
############# START Certificate Import     ##############
######################################################
module "dlm_hdfcbank_com" {
  source              = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-acm"
  name                = "dlm_hdfcbank_com"
  environment         = "prod"
  label_order         = ["name"]
  private_key         = "../prod-ssl/dlm_hdfcbank_com.key"
  certificate_body    = "../prod-ssl/dlm_hdfcbank_com.cer"
  certificate_chain   = "../prod-ssl/dlm_hdfcbank_com.crt"
  import_certificate  = true
 #tags                = var.additional_tags

  tags = merge(
    { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "dlm_hdfcbank_com"]) ,
      ProvisioningDate = "18-feb-2025"} , var.additional_tags
  )
}
######################################################
#############  END Certificate Import     ##############
######################################################
