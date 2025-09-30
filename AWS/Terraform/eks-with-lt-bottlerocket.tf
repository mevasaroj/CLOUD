

# export ip=$(aws eks describe-cluster --query "cluster.kubernetesNetworkConfig.serviceIpv4Cidr" --output text --name '${module.app_eks.cluster_name}' --region ap-south-1 | sed -E 's/([0-9]+\.[0-9]+\.[0-9]+)\.[0-9]+.*/\1.10/')
################################################################################
# User Data configuration & Proxy Settings
################################################################################
#BottleRocket userdata
locals {
app-eks-node-private-userdata-bottlerocket = <<USERDATA
[settings.kubernetes]
"api-server" = "${module.app_eks_bottlerocket.cluster_endpoint}"
"cluster-certificate" = "${module.app_eks_bottlerocket.cluster_certificate_authority_data}"
"cluster-name" = "${module.app_eks_bottlerocket.cluster_name}"
"cluster-dns-ip" = "172.20.0.10"
[settings.network]
https-proxy = "awsappproxy.corp.hdfcbank.com:3128"
no-proxy = ["localhost", "127.0.0.1", "172.20.0.0/16", ".internal", "github.hdfcbank.com", ".hbctxdom.com", "10.226.72.255", "10.*", "100.*", "169.254.169.254", ".hdfcbankapps.com", "api.serviceurl.in", "staticdownloads.site24x7.in", "staticdownloads.site24x7.com", "hdplus.site24x7.in", "hdlogu.site24x7.in", "hdplus2.site24x7.in", "hdplusinsight.site24x7.in"]

USERDATA
}

#################################################################################################################################################
# Custom Launch Template for Managed Node groups
#################################################################################################################################################

module "bottlerocket-ondemand-lt" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-autoscaling"
  create = false   # AUTOSCALING GROUP
  
  name                   = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "bottlerocket-ondemand-launch-template"])
  key_name               = var.infra_key
  image_id               = "ami-02edffcbb8817ce40" # BottleRocket - x86_64
  instance_type          = "m6a.xlarge" # For On-Demand - x86_64
  user_data              = base64encode(local.app-eks-node-private-userdata-bottlerocket)
  update_default_version = true
  security_groups        = ["${var.eks-cluster-workernode-sg}"]
  enable_monitoring      = false
  
  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      ebs = {
        encrypted    = true
        volume_size           = 2
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/mrk-17ba28fbb760408e8d35ce0f854a00b5"
      }      
      },
      {
      # Root volume
      device_name = "/dev/xvdb"
      ebs = {
        encrypted    = true
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/mrk-17ba28fbb760408e8d35ce0f854a00b5"
      }      
      }
  ]
   
  metadata_options       = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit =  2
    instance_metadata_tags      = "enabled"
  }
   

  tag_specifications = [
    {
    resource_type = "instance"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ondemand-eks-node"])
          } ) },
    {
    resource_type = "volume"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ondemand-eks-node-volume"])
          } ) },
    {
    resource_type = "network-interface"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "ondemand-eks-node-eni"])
      } ) }
   ]
  
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "bottlerocket-ondemand-launch-template"]) }, 
    var.additional_tags ) 
}
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------

module "bottlerocket-spot-lt" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-autoscaling"
  create = false   # AUTOSCALING GROUP
  
  name                   = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "bottlerocket-spot-launch-template"])
  key_name               = var.infra_key
  image_id               = "ami-02edffcbb8817ce40" # BottleRocket - x86_64
  user_data              = base64encode(local.app-eks-node-private-userdata-bottlerocket)
  update_default_version = true
  security_groups        = ["${var.eks-cluster-workernode-sg}"]
  enable_monitoring      = false
  
  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      ebs = {
        encrypted    = true
        volume_size           = 2
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/mrk-17ba28fbb760408e8d35ce0f854a00b5"
      }      
      },
      {
      # Root volume
      device_name = "/dev/xvdb"
      ebs = {
        encrypted    = true
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/mrk-17ba28fbb760408e8d35ce0f854a00b5"
      }      
      }
  ]
   
  metadata_options       = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit =  2
    instance_metadata_tags      = "enabled"
  }
   

  tag_specifications = [
    {
    resource_type = "instance"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "spot-eks-node"])
          } ) },
    {
    resource_type = "volume"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "spot-eks-node-volume"])
          } ) },
    {
    resource_type = "network-interface"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "spot-eks-node-eni"])
      } ) }
   ]
  
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "bottlerocket-spot-launch-template"]) }, 
    var.additional_tags ) 
}


##############################################################################################################################################################
# EKS Cluster & Managed Node groups Module
##############################################################################################################################################################

module "app_eks_bottlerocket" {

  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-eks"
  create = true

  cluster_name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "cluster"])
  cluster_version = "1.31"

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true
  create_cloudwatch_log_group     = false

  vpc_id                                = var.nonpcidss-prod-vpc
  control_plane_subnet_ids              = ["${var.cp-subnet-aza}", "${var.cp-subnet-azb}", "${var.cp-subnet-azc}"]
  create_cluster_security_group         = false
  cluster_security_group_id             = var.eks-cluster-additional-sg
  cluster_additional_security_group_ids = ["${var.eks-cluster-additional-sg}"]

  create_node_security_group = false
  node_security_group_id     = var.eks-cluster-workernode-sg

  enable_irsa     = true
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::593793066189:role/hbl-aws-cam-role-eks-cluster-dlm-uat"

  #===========================
  # EKS Cluster Encryption
  #===========================
  create_kms_key = false
  cluster_encryption_config = {
    resources : [
      "secrets"
    ],
    provider_key_arn = "arn:aws:kms:ap-south-1:911372318716:key/mrk-17ba28fbb760408e8d35ce0f854a00b5"
  }

  #===========================
  # EKS Cluster Logging
  #===========================

  cluster_enabled_log_types = ["audit", "api", "authenticator", "controllerManager", "scheduler"]

  
  #===========================
  # EKS Managed Addons
  #===========================

  cluster_addons = {
    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-coredns"])
        })
    }
    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-kube-proxy"])
        } )
    }
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = jsonencode({
        env = {
           AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
           ENI_CONFIG_LABEL_DEF = "topology.kubernetes.io/zone"
           ENABLE_PREFIX_DELEGATION = "true" 
           WARM_PREFIX_TARGET = "1"
        }})	  
    	tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-efs-csi-driver"])
         })
     }
    aws-efs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-efs-csi-driver"])
         })
     }
     aws-ebs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-ebs-csi-driver"])
         })
     }
    }

  #===========================
  # EKS Managed Nodegroups
  #===========================
  eks_managed_node_group_defaults = {
    cluster_version                 = null
    use_name_prefix                 = false
    use_custom_launch_template      = true
    create_launch_template          = false
    launch_template_use_name_prefix = false
    create_iam_role                 = false
    iam_role_arn                    = "arn:aws:iam::593793066189:role/hbl-aws-cam-role-eks-workernode-dlm-uat"
    force_update_version            = true
    update_config = {
      max_unavailable_percentage = "10"
    }
  }

eks_managed_node_groups = {
   ondemand = {
      name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, local.env, "ondemand"])
      min_size           = 1      
      desired_size       = 1
      max_size           = 1
      launch_template_id = module.bottlerocket-ondemand-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"  
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "ondemand"])
        }
      )
    },	   
   spot = {
      name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, local.env, "spot"])
      min_size           = 0
      desired_size       = 2
      max_size           = 10
      launch_template_id = module.bottlerocket-spot-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "SPOT"
      #instance_types     = [ "c6a.xlarge", ]
      instance_types     = [ "c5.xlarge","c5a.xlarge","c5d.xlarge","c6a.xlarge","c6i.xlarge","c6in.xlarge","c7i.xlarge","c7i-flex.xlarge","inf1.xlarge" ]
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "spot"])
        }
      )
    }    
  }

# Cluster Tags
  tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "bottlerocket-cluster"])
    } )
	   
}
  
#=================================================================================================================================================================
