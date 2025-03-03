
##################################################################
# Start of Network Load Balancer
##################################################################

module "dmz-nlb" {
  source = "terraform-aws-modules/alb/aws"
  name   = join("-", [local.org, local.csp, local.account, "dmz-nlb"])  # - Max 32 Characters
  load_balancer_type         = "network"
  vpc_id                     = var.dmz-prod-vpc
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
      subnet_id = var.dmz-web-subnet-aza
      private_ipv4_address = "10.199.95.10"
    },
    {
      subnet_id = var.dmz-web-subnet-azb
      private_ipv4_address = "10.199.95.42"
    },
    {
      subnet_id = var.dmz-web-subnet-azc
      private_ipv4_address = "10.199.95.74" 
   }
  ]

  # Security Group
  create_security_group = false
  security_groups     = ["${var.dmz-web-sg}"]

  # Access Log
  access_logs         = {
    bucket = "hbl-aws-aps1-nonpcidss-prod-dlm-load-balancer-log-bucket"
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
        target_group_key = "dmz-nlb-tg"
      }
    }
  }
  
  # END OF listeners
#=========================================================================================
  # START OF Target Group
  # ------------------------------------------
  target_groups = {
    dmz-nlb-tg = {
      name                 = join("-", [local.org, local.csp, local.account, "dmz-nlb-tg"])
      protocol             = "TCP"
      port                 = 443
      target_type          = "ip"
      preserve_client_ip   = true
      deregistration_delay = 10
      create_attachment = false

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
    tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "dmz-nlb-tg"])}",
        ProvisioningDate = "03-March-2025"},
        var.additional_tags)
	  
    }

  }
  # END OF Target Group
#=========================================================================================

  # LB TAGS
  tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "dmz-nlb"])}",
    ProvisioningDate = "03-March-2025"},
    var.additional_tags)
}

################################################################################
# End of Network Load Balancer
################################################################################

resource "aws_lb_target_group_attachment" "dmz-web-subnet-aza" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.196.212.11"
  port             = 443
  availability_zone = "all"
}


resource "aws_lb_target_group_attachment" "dmz-web-subnet-azb" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.196.212.80"
  port             = 443
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "dmz-web-subnet-azc" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.196.212.139" 
  port             = 443
  availability_zone = "all"
}
################################################################################
# End of Attachment Load Balancer
################################################################################
