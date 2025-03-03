

module "load-balancer-log-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "load-balancer-log-bucket"])
  acl           = "log-delivery-write"
  force_destroy = true
    
  object_ownership   = "ObjectWriter"
  control_object_ownership = true

  # Public Access Policy
  attach_public_policy = false


  attach_elb_log_delivery_policy = true # Required for ALB logs
  attach_lb_log_delivery_policy  = true # Required for ALB/NLB logs

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  # Bucket Policy
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
                    "${module.load-balancer-log-bucket.s3_bucket_arn}/*",
                    "${module.load-balancer-log-bucket.s3_bucket_arn}",
                ]
                Condition = {
                    Bool = {
                        "aws:SecureTransport" = "false"
                    }
                }       
            }
        ]
    })
	
    # Bucket Life-cycle
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
          days          = 180
          storage_class = "DEEP_ARCHIVE"
        }
      ]
    expiration = {
      days = 365
      #expired_object_delete_marker = true
    }
   },
  ]
  
  # Bucket Versioning
  versioning = {
    enabled = false
  }
  
  # Bucket Tags
  tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "load-balancer-log-bucket"])}",
    ProvisioningDate = "03-March-2025"},
    var.additional_tags)
	
}
