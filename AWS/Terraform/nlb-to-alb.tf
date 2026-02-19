#============================================================
### START OF ALB ####
#============================================================
module "app-nlb" {
  source              = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-load-balancer_v6"
  name                = join("-", [local.org, local.csp, local.region, local.vpcname, "app-nlb"])  # - Max 32 Characters
  vpc_id              = var.nonpcidss-prod-vpc
  internal            = true
  load_balancer_type  = "network"  
  drop_invalid_header_fields = true
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = true
  preserve_host_header = true
  
  # Security Group
  create_security_group = false
  security_groups     = ["${var.app-alb-sg}"]

  # Subnet Mapping
  subnet_mapping = [
    {
      subnet_id = var.infra-subnet-aza
      private_ipv4_address = "10.213.12.10"
    },
    {
      subnet_id = var.infra-subnet-azb
      private_ipv4_address = "10.213.12.138"
    },
    {
      subnet_id = var.infra-subnet-azc
      private_ipv4_address = "10.213.13.10"
   }
  ]
     

  access_logs         = {
    bucket = "hbl-aws-aps1-nonpcidss-uat-xcl-load-balancer-log-bucket"
    prefix = join("-", [local.org, local.csp, local.region, local.vpcname, "app-nlb"])
    enabled = true
  }


#=========================================================================================
  
  # START OF listeners
  # -------------------------------------------
  listeners = {
    ex-tcp = {
      port            = 443
      protocol        = "TCP"
      target_group_index = 0
      load_balancer_arn  = "arn:aws:elasticloadbalancing:ap-south-1:972742752662:loadbalancer/app/k8s-ekstest-applycar-7849a4e025/f1f4736e61b949f2"
      forward = {
        target_group_key = "nlb-tg"
      }

    }
  }
  
 # END OF listeners
 
#=========================================================================================
  # START OF Target Group
  # -------------------------------------------
  target_groups = {
    nlb-tg = {
      namex       = join("-", [local.org, local.csp, local.region, local.vpcname, "nlb-tg"])
      protocol    = "TCP"
      port        = 443
      target_type = "alb"
      preserve_client_ip = true
      target_id   = "arn:aws:elasticloadbalancing:ap-south-1:972742752662:loadbalancer/app/k8s-ekstest-applycar-7849a4e025/f1f4736e61b949f2"

      health_check = {
        path                = "/"
        enabled             = true
        interval            = 30        
        port                = 443
        healthy_threshold   = 3
        unhealthy_threshold = 5
        timeout             = 5
        protocol            = "HTTPS"
        matcher             = "200-450"
      }
      # Target Group Tags  
   tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "nlb-tg"])}"}, 
    var.additional_tags)
		
    }
	
  }
  # END OF Target Group
#=========================================================================================


# ALB TAGS
tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "app-nlb"])}"}, 
    var.additional_tags)
  
}

#============================================================
### END OF ALB ####
#============================================================
