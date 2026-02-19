
##################################################################
# Start of Network Load Balancer
##################################################################

module "dmz-nlb" {
 # source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-load-balancer"
  source              = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-load-balancer_v6"
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

  # Security Group
  create_security_group = false
  security_groups     = ["${var.dmz-nlb-sg}"]

  # Use `subnet_mapping` to attach IPs
  subnet_mapping = [
    {
      subnet_id = var.dmz-web-subnet-aza
      private_ipv4_address = "10.215.130.10"
    },
    {
      subnet_id = var.dmz-web-subnet-azb
      private_ipv4_address = "10.215.130.42"
    },
    {
      subnet_id = var.dmz-web-subnet-azc
      private_ipv4_address = "10.215.130.74" 
   }
  ]

  # Access Log
  access_logs         = {
    bucket = "hbl-aws-aps1-nonpcidss-uat-xcl-load-balancer-log-bucket"
    prefix = "dmz-nlb"
    enabled = true
  }

#=========================================================================================
  # START OF listeners
  # -------------------------------------------
  listeners = {
    nonpcidss-listeners = {
      port            = 443
      protocol        = "TLS"
      certificate_arn = "arn:aws:acm:ap-south-1:972742752662:certificate/ab63dc4f-c120-48ef-87f8-d99e20b2d977"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
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
      protocol             = "TLS"
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
        matcher             = "200-399"
        protocol            = "HTTPS"
      }
	  
    # nonpcidss-nlb-tg Tags
    tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "dmz-nlb-tg"])}"},
        var.additional_tags)
	  
    }

  }
  # END OF Target Group
#=========================================================================================

  # LB TAGS
  tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "dmz-nlb"])}"},
    var.additional_tags)
}

################################################################################
# End of Network Load Balancer
################################################################################

resource "aws_lb_target_group_attachment" "dmz-web-subnet-aza" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.213.12.10"
  port             = 443
  availability_zone = "all"
}


resource "aws_lb_target_group_attachment" "dmz-web-subnet-azb" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.213.12.138"
  port             = 443
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "dmz-web-subnet-azc" {
  depends_on = [ module.dmz-nlb.target_groups ]
  target_group_arn = module.dmz-nlb.target_groups["dmz-nlb-tg"].arn
  target_id        = "10.213.13.10"
  port             = 443
  availability_zone = "all"
}
################################################################################
# End of Attachment Load Balancer
################################################################################
