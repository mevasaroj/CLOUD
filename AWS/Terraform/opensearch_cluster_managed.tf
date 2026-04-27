 module "opensearch" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-opensearch"


   # Domain
  advanced_options = {
     "rest.action.multi.allow_explicit_index" = "true"
   }

  advanced_security_options = {
     enabled                        = true
     anonymous_auth_enabled         = false
     internal_user_database_enabled = true

     master_user_options = {
       master_user_name     = "genai"
       master_user_password = "HdfcBank123$"
     }
   }

  auto_tune_options = {
     desired_state = "ENABLED"

     maintenance_schedule = [
       {
         start_at                       = "2028-05-13T07:44:12Z"
         cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
         duration = {
           value = "2"
           unit  = "HOURS"
         }
       }
     ]

     rollback_on_disable = "NO_ROLLBACK"
   }

  cluster_config = {
	  
     instance_count           = 2
     dedicated_master_enabled = true
     dedicated_master_count   = 0
     dedicated_master_type    = "r6g.large.search"
     instance_type            = "r6g.large.search"
#      warm_count               = 2
#      warm_enabled             = false
#      warm_type                = "ultrawarm1.large.search"
  

     zone_awareness_config = {
       availability_zone_count = 2
     }

     zone_awareness_enabled = false
   }

  domain_endpoint_options = {
     enforce_https       = true
     tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
   }

  domain_name     = join("-", [local.org, local.csp, local.account, "os"])
 
  ebs_options = {
     ebs_enabled = true
     iops        = 3000
     throughput  = 250
     volume_type = "gp3"
     volume_size = 200
   }

  encrypt_at_rest = {
     enabled = true
 	kms_key_id = "arn:aws:kms:ap-south-1:911372318716:key/mrk-3dcfa40baedf4aeebf05ff4d6a1636a7"
   }

  engine_version = "OpenSearch_2.5"
  
  log_publishing_options = [
    { log_type = "INDEX_SLOW_LOGS" },
    { log_type = "SEARCH_SLOW_LOGS" },
    { log_type = "ES_APPLICATION_LOGS" },
    { log_type = "AUDIT_LOGS" },
  ]

  node_to_node_encryption = {
     enabled = true
   }

  software_update_options = {
     auto_software_update_enabled = true
   }
	
  vpc_options = {
     security_group_ids = ["${var.db-sg}"]  
     subnet_ids = ["${var.db-subnet-aza}"]
   }

   # VPC endpoint
  vpc_endpoints = {
     one = {
       security_group_ids = ["${var.vpc-endpoints-sg}"] 
       subnet_ids = ["${var.infra-subnet-aza}", "${var.infra-subnet-azb}"]
     }
   }

 access_policy_statements = [ { 
    effect = "Allow"
    principals = [{
        type        = "AWS"
        identifiers = ["*"]
      }]
     actions = ["es:*"]
     resources = ["arn:aws:es:ap-south-1:273354645607:domain/hbl-aws-genai-os/*"]
    } ]

 create_cloudwatch_log_groups = true	
 create_security_group = false

   tags = merge({ Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "opensearch"]),
       AutoRestart = "True" }, 
 	  var.additional_tags )
 }
