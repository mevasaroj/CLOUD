
##################################################################
# User Data configuration & Proxy Settings
################################################################################
#BottleRocket userdata
locals {
userdata-bottlerocket = <<USERDATA
[settings.kubernetes]
"api-server" = "${module.app_eks_bottlerocket.cluster_endpoint}"
"cluster-certificate" = "${module.app_eks_bottlerocket.cluster_certificate_authority_data}"
"cluster-name" = "${module.app_eks_bottlerocket.cluster_name}"
USERDATA
}

/*
[settings.network]
https-proxy = "awsappproxy.corp.hdfcbank.com:3128"
no-proxy = ["localhost", "127.0.0.1", "172.20.0.0/16", ".internal", "github.hdfcbank.com", ".hbctxdom.com", "10.226.72.255", "10.*", "100.*", "169.254.169.254", ".hdfcbankapps.com", "api.serviceurl.in", "staticdownloads.site24x7.in", "staticdownloads.site24x7.com", "hdplus.site24x7.in", "hdlogu.site24x7.in", "hdplus2.site24x7.in", "hdplusinsight.site24x7.in"]
*/
#######################################################################################################################
# Custom Launch Template for Managed Node groups
#######################################################################################################################

module "bottlerocket-lt" {
 # source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-autoscaling"
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-autoscaling_v6"
  create = false   # AUTOSCALING GROUP
  
  name                   = join("-", [local.org, local.csp, local.account, local.vpcname, local.env, "bottlerocket-lt"])
  user_data              = base64encode(local.userdata-bottlerocket)
  update_default_version = true
  security_groups        = ["${var.eks-cluster-workernode-sg}"]
  enable_monitoring      = false
  
  block_device_mappings = [
    { # Root volume
      device_name = "/dev/xvda"
      ebs = {
        encrypted    = true
        volume_size           = 2
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/1e884af2-73cd-4132-9612-d9dd72d981e0"
      }},
      {  # Root volume 
      device_name = "/dev/xvdb"
      ebs = {
        encrypted    = true
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/1e884af2-73cd-4132-9612-d9dd72d981e0"
      }}
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
      Name = join("-", [local.org, local.csp, local.vpcname, local.env, local.account, "eks-node"])
          } ) },
    {
    resource_type = "volume"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.vpcname, local.env, local.account, "eks-node-volume"])
          } ) },
    {
    resource_type = "network-interface"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.vpcname, local.env, local.account, "eks-node-eni"])
      } ) }
   ]

# Launch Template Tags
  tags = merge( { Name = join("-", [local.org, local.csp, local.vpcname, local.env, local.account, "bottlerocket-lt"]) }, 
    var.additional_tags ) 
}


##############################################################################################################################################################
# EKS Cluster & Managed Node groups Module
##############################################################################################################################################################

module "app_eks_bottlerocket" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-eks_v6"
  create = true

  name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "cluster"])
  kubernetes_version = "1.33"

  endpoint_public_access  = false
  endpoint_private_access = true
  


create_cloudwatch_log_group     = false
  vpc_id                                = var.nonpcidss-prod-vpc
  #service_ipv4_cidr             = "10.211.128.0/24"
  control_plane_subnet_ids              = ["${var.cp-subnet-aza}", "${var.cp-subnet-azb}", "${var.cp-subnet-azc}"]
  create_security_group = false  
  additional_security_group_ids     = ["${var.eks-cluster-workernode-sg}"]
  #security_group_id  = ["${var.eks-cluster-workernode-sg}"]
  

  create_node_security_group = false
  node_security_group_id     = var.eks-cluster-workernode-sg

  enable_irsa     = true
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::216066832707:role/hbl-aws-aps1-application-uat-eks-cluster-role"
enabled_log_types=["audit", "api", "authenticator", "controllerManager", "scheduler"]

#--------------------------------------------
# EKS Cluster Encryption
#--------------------------------------------
  create_kms_key = false
  encryption_config = {
    resources : [ "secrets" ],
    provider_key_arn = "arn:aws:kms:ap-south-1:911372318716:key/1e884af2-73cd-4132-9612-d9dd72d981e0"
  }

#--------------------------------------------
# Acccess entries to accesss cluster
#--------------------------------------------
access_entries = {
    # One access entry with a policy associated
    admin = {
      principal_arn = "arn:aws:iam::216066832707:role/hbl-aws-role-tfeappinfra-sharedservices-infra-uat"

      policy_associations = {
        policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            #namespaces = ["default"]
            type       = "cluster"
          }
        }
      }
    }
  }
  #--------------------------------------------
  # EKS Managed Addons
  #--------------------------------------------
 

  addons = {
    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "coredns"])})
    }
    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "kube-proxy"])})
    }
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
/*
      configuration_values = jsonencode({
        env = {
           AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
           AWS_VPC_K8S_CNI_EXTERNALSNAT = "false"
           ENI_CONFIG_LABEL_DEF = "topology.kubernetes.io/zone"
           ENABLE_PREFIX_DELEGATION = "true"            
           WARM_PREFIX_TARGET = "1"
        }})
*/
    	tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "vpc-cni"])})
     }    
    aws-efs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       service_account_role_arn = "arn:aws:iam::216066832707:role/hbl-aws-aps1-appname-uat-eks-workernode-role"
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "efs-csi-driver"])})
     }
     aws-ebs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "PRESERVE"
       service_account_role_arn = "arn:aws:iam::216066832707:role/hbl-aws-aps1-appname-uat-eks-workernode-role"
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "ebs-csi-driver"])})
     }
    }

  #===========================
  # EKS Managed Nodegroups
  #===========================
  eks_managed_node_groups = {
   ondemand-ng = {
      name    = join("-", [local.org,  local.csp, local.account, local.env, "ondemand-ng"])
      min_size           = 1      
      desired_size       = 1
      max_size           = 1
      create_iam_role    = false
      iam_role_arn = "arn:aws:iam::216066832707:role/hbl-aws-aps1-appname-uat-eks-workernode-role"
      ami_type       = "BOTTLEROCKET_x86_64"
      launch_template_id = module.bottlerocket-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"
      instance_types     = [ "c6a.2xlarge" ]
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org,  local.csp, local.account, local.vpcname, local.env, "ondemand-ng"])})
    }

  }

# Cluster Tags
  tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "bottlerocket-cluster"])
    } )
	   
}

	
/*
#===============================================================================================================================================

#=================================================================================================================================================================
  
locals { pods-subnet = { 
    "ap-south-1a" = "subnet-0d31cf97ba9de98a0",
    "ap-south-1b" = "subnet-01e4fee1256fed9cd",
    "ap-south-1c" = "subnet-0dd0572cf736d0866" 
}}
	
data "aws_eks_cluster" "cluster" {
  name = module.app_eks_bottlerocket.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.app_eks_bottlerocket.cluster_name
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(module.app_eks_bottlerocket.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.app_eks_bottlerocket.cluster_id]
    command     = "aws"
  }
}


resource "kubectl_manifest" "eniconfig" {
  for_each  = tomap(local.pods-subnet)
  yaml_body = <<-YAML
  apiVersion: crd.k8s.amazonaws.com/v1alpha1
  kind: ENIConfig
  metadata: 
    name: ${each.key}
    namespace: default
  spec: 
    securityGroups: 
      - ${var.eks-cluster-workernode-sg}
    subnet: ${each.value}
  YAML
}

*/
#=================================================================================================================================================================
