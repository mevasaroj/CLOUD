
##################################################################
# Start of Network Load Balancer
##################################################################

module "app-alb" {
  source = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-load-balancer"
  name   = join("-", [local.org, local.csp, local.account, "app-alb"])  # - Max 32 Characters
  load_balancer_type         = "application"
  vpc_id                     = "vpc-0b141d5f35fb70ab2"
  internal                   = true
  preserve_host_header       = false
  drop_invalid_header_fields = false
  #enable_deletion_protection = true
  desync_mitigation_mode     = "defensive"
  enable_cross_zone_load_balancing = true
  dns_record_client_routing_policy = "availability_zone_affinity"
  subnets             = [var.infra-subnet-aza, var.infra-subnet-azb, var.infra-subnet-azc]

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
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      certificate_arn = "arn:aws:acm:ap-south-1:216066832707:certificate/74f7d8aa-f550-4581-a0db-b53cbca0f505"

      forward = {
        target_group_key = "app-tg"
      }

      rules = {
        web-1st-priority = {
        priority = 1
        actions = [
             {
              type             = "forward"
              target_group_key = "app-tg"
            }
          ]

          conditions = [{
            path_pattern = {
              values = ["/some/auth/required/route"]
            }
          }]
        }
      },
     app-2st-priority = {
        priority = 2
        actions = [
             {
              type             = "forward"
              target_group_key = "app-tg"
            }
          ]

          conditions = [{
            path_pattern = {
              values = ["/2nd_priotry"]
            }
          }]
        }

    }
  }
  
 # END OF listeners


#=========================================================================================
  # START OF Target Group
  # -------------------------------------------
  target_groups = {
    app-tg = {
      name                 = join("-", [local.org, local.csp, local.account, "app-alb-tg"])
      protocol             = "HTTPS"
      port                 = 443
      target_type          = "instance"
      deregistration_delay = 10
      create_attachment = false

      health_check = {
        path                = "/"
        enabled             = true
        interval            = 30        
        port                = 443
        healthy_threshold   = 3
        unhealthy_threshold = 5
        timeout             = 5
        protocol            = "HTTPS"
        matcher             = "200-399"
      }
    # Target Group Tags  
    tags = merge({Name = "${join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-tg"])}",
        ProvisioningDate = "20-Dec-2024"},
        var.additional_tags)
		}
	
  }
  # END OF Target Group

#=========================================================================================


  # LB TAGS
  tags = merge({Name = "${join("-", [local.org, local.csp, local.account, "app-alb"])}",
    ProvisioningDate = "03-March-2025"},
    var.additional_tags)
}

################################################################################
# End of Network Load Balancer
################################################################################
locals {
  web_instance = {
    trg1  = "i-0c8037c512e41adef",
    trg2  = "i-0bd60fc05d996e91e",
    trg3  = "i-0bd6b65ec886f9f0c"
    }
  }


resource "aws_lb_target_group_attachment" "tg_attachment" {
depends_on = [ module.app-alb.target_groups ]
for_each = { for idx, tg in local.web_instance : idx => tg }
  target_group_arn  = module.app-alb.target_groups["app-tg"].arn
  target_id         = each.value
  port              = 443
  availability_zone = "all"
}




################################################################################
# End of Attachment Load Balancer
################################################################################
