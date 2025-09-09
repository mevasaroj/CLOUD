module "s3-object-bucket" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-s3-bucket_v6"
  #version = "1.2.6"
  bucket = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "s3-object-bucket"])
  acl    = "private"
  force_destroy = true
  attach_public_policy = false  
  object_ownership     = "ObjectWriter"  
  versioning = { enabled = false }
  control_object_ownership = true
  transition_default_minimum_object_size = "varies_by_storage_class"
 
  attach_policy = true
  policy = jsonencode({
        Version = "2012-10-17"
        Id      = "BUCKET-POLICY"
        Statement = [
            {
                Sid       = "EnforceTls"
                Effect    = "Deny"
                Principal = "*"
                Action    = "s3:*"
                Resource = [
                    "${module.s3-object-bucket.s3_bucket_arn}/*",
                    "${module.s3-object-bucket.s3_bucket_arn}",
                ]
                Condition = {
                    Bool = {
                        "aws:SecureTransport" = "false"
                    }
                }       
            }
        ]
    })
	
  server_side_encryption_configuration = {
    rule = {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default = {
      sse_algorithm = "aws:kms"
      kms_master_key_id = "arn:aws:kms:ap-south-1:911372318716:key/1e884af2-73cd-4132-9612-d9dd72d981e0"
      }
    }
  }
  
  lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      transition = [
         {
          days          = 60
          storage_class = "GLACIER"
        },
        {
          days          = 365
          storage_class = "DEEP_ARCHIVE"
        }
      ]
	  },
  ]
       
  tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "s3-object-bucket"])}", ProvisioningDate = "11-Oct-2024"}, 
    var.additional_tags)
  
}
