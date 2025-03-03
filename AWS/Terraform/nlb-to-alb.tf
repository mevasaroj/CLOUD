##################################################################
# Start of Network Load Balancer
##################################################################

module "nonpcidss-nlb" {
  source = "terraform-aws-modules/alb/aws"
  name   = join("-", [local.org, local.csp, local.account, "nonpcidss-nlb"])  # - Max 32 Characters
  load_balancer_type         = "network"
  vpc_id                     = var.nonpcidss-prod-vpc
  internal                   = true
  preserve_host_header       = false
  drop_invalid_header_fields = false
  enable_deletion_protection = true
  desync_mitigation_mode     = "defensive"
  enable_cross_zone_load_balancing = true
  dns_record_client_routing_policy = "availability_zone_affinity"

  # Use `subnet_mapping` to attach IPs
  subnet_mapping = [
    {
      subnet_id = var.infra-subnet-aza
      private_ipv4_address = "10.196.212.11"
    },
    {
      subnet_id = var.infra-subnet-azb
      private_ipv4_address = "10.196.212.80"
    },
    {
      subnet_id = var.infra-subnet-azc
      private_ipv4_address = "10.196.212.139" 
   }
  ]

  # Security Group
  create_security_group = false
  security_groups     = ["${var.app-alb-sg}"]


  # Access Log
  access_logs         = {
    bucket ="hbl-aws-aps1-nonpcidss-prod-dlm-load-balancer-log-bucket"
    prefix = "nonpcidss-nlb"
    enabled = true
  }

#=========================================================================================
  # START OF listeners
  # -------------------------------------------
  listeners = {
    nonpcidss-listeners = {
      port                     = 443
      protocol                 = "TCP"
      tcp_idle_timeout_seconds = 60
      forward = {
        target_group_key = "nonpcidss-nlb-tg"
      }
    }
  }
  
  # END OF listeners
#=========================================================================================

  # START OF Target Group
  # ------------------------------------------
  target_groups = {
    nonpcidss-nlb-tg = {
      name                 = join("-", [local.org, local.csp, local.account, "nonpcidss-nlb-tg"])
      protocol             = "TCP"
      port                 = 443
      target_type          = "alb"
      preserve_client_ip   = true
      target_id            = "arn:aws:elasticloadbalancing:ap-south-1:686255955923:loadbalancer/app/hbl-aws-dlm-nonpcidss-prod-alb/84c5a8d8fe47a504"
      deregistration_delay = 10
	  
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }

      # nonpcidss-nlb-tg Tags
      tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "nonpcidss-nlb-tg"])}",
        ProvisioningDate = "03-March-2025"},
        var.additional_tags)
	  
    }

  }
  # END OF Target Group

#=========================================================================================

  # LB TAGS
  tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "nonpcidss-nlb"])}",
    ProvisioningDate = "03-March-2025"},
    var.additional_tags)
}

################################################################################
# End of Network Load Balancer
################################################################################
