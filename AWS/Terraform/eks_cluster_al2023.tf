################################################################################
# Kubernetes provider configuration##############
################################################################################

provider "tls" {
  alias = "al2023-eks-cluster"
  proxy {
    from_env = true
  }
}

provider "kubernetes"{
  alias                  = "al2023-eks-cluster"
  host                   = module.al2023-eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.al2023-eks-cluster.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.al2023-eks-cluster.cluster_name]
  }
}

################################################################################
# User Data configuration & Proxy Settings
################################################################################

locals {

al2023-userdata = <<USERDATA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
export eksclustercertificate=$(aws eks describe-cluster --query "cluster.certificateAuthority.data" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
export apiserverendpoint=$(aws eks describe-cluster --query "cluster.endpoint" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
export cidr=$(aws eks describe-cluster --query "cluster.kubernetesNetworkConfig.serviceIpv4Cidr" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
cat > nodeadm.yaml<<EOF
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: $apiserverendpoint
    certificateAuthority: $eksclustercertificate
    cidr: $cidr
    name: '${module.al2023-eks-cluster.cluster_name}'
EOF
nodeadm init --config-source file://nodeadm.yaml



--==MYBOUNDARY==--

USERDATA

}


#################################################################################################################################################
# Custom Launch Template for Managed Node groups
#################################################################################################################################################

module "al2023-ondemand-lt" {
  source  = "terraform-aws-modules/autoscaling/aws"
  create = false   # AUTOSCALING GROUP
  
  name                   = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "al2023-ondemand-lt"])
  user_data              = base64encode(local.al2023-userdata)
  update_default_version = true
  security_groups        = ["${var.eks-cluster-workernode-sg}"]
  enable_monitoring      = false
  
  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      ebs = {
        encrypted    = true
        #volume_size           = 2
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/17cbe4eb-fe74-49ed-a177-72bf19a0734c"
      }      
    },
    {
      # Root volume
      device_name = "/dev/xvdb"
      ebs = {
        encrypted    = true
        #volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
        kms_key_id   = "arn:aws:kms:ap-south-1:911372318716:key/17cbe4eb-fe74-49ed-a177-72bf19a0734c"
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
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node"])
          } ) },
    {
    resource_type = "volume"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node-volume"])
          } ) },
    {
    resource_type = "network-interface"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node-eni"])
      } ) }
   ]
  
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-lt"]) }, 
    var.additional_tags ) 
}


##############################################################################################################################################################
# EKS Cluster & Managed Node groups Module 
##############################################################################################################################################################

module "al2023-eks-cluster" {

  providers = {
    tls        = tls.al2023-eks-cluster
  }


  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-eks_v6"
  create = true

  cluster_name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "al2023-eks-cluster"])
  cluster_version = "1.35"

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true
  create_cloudwatch_log_group     = false

  create_cloudwatch_log_group   = false
  vpc_id                        = var.nonpcidss-prod-vpc
  service_ipv4_cidr             = "10.199.88.0/24" # DMZ CIDR - Outside of EKS VPC CID
  subnet_ids              = ["${var.cp-subnet-aza}", "${var.cp-subnet-azb}", "${var.cp-subnet-azc}"]
  create_security_group = false  
  additional_security_group_ids     = ["${var.eks-cluster-sg}"]

  create_node_security_group = false
  node_security_group_id     = var.eks-cluster-sg

  enable_irsa     = true
  create_iam_role = false
  iam_role_arn    = "<EKS-Cluster-Role-ARN>"  # # REPLACE WITH EKS-Cluster-Role ARN
  
  # Control PLane Logging 
  enabled_log_types = ["audit", "api", "authenticator", "controllerManager", "scheduler"]

  #===========================
  # EKS Cluster Encryption
  #===========================

  create_kms_key = false
  cluster_encryption_config = {
    resources : [
      "secrets"
    ],
    provider_key_arn = "<KMS-Key-ARN>"
  }
  
  #--------------------------------------------
  # Acccess entries to accesss cluster
  #--------------------------------------------
   access_entries = {
    # One access entry with a policy associated
    admin = {
      principal_arn = "arn:aws:iam::281845296445:role/hbl-aws-role-tfeappinfra-xcl-prod"

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
  cluster_addons = {
    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-coredns"])
        }
      )
    }
    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-kube-proxy"])
        }
      )
    }
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = jsonencode({
        env = {
           AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
           AWS_VPC_K8S_CNI_EXTERNALSNAT = "false"
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
       service_account_role_arn = "<eks-efs-role-arn>" # # REPLACE WITH EKS-EFS-Role ARN
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-efs-csi-driver"])
         })
     }
     aws-ebs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       service_account_role_arn = "<eks-ebs-role-arn>" # # REPLACE WITH EKS-EBS-Role ARN
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-ebs-csi-driver"])
         })
     }
    }

  #===========================
  # EKS Managed Nodegroups
  #===========================
 eks_managed_node_groups = {
  ondemand = {
      name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, local.env, "ondemand-ng"])
	  ami_type           = "AL2023_x86_64_STANDARD"
      instance_types     = ["m6a.xlarge"]
      min_size           = 1      
      desired_size       = 1
      max_size           = 1
      launch_template_id = module.al2023-ondemand-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"  
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "ondemand-ng"])
      })
    },
  spot = {
      name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, local.env, "spot-ng"])
	  ami_type           = "AL2023_x86_64_STANDARD"
      instance_types     = [ "c5.xlarge","c5a.xlarge","c5d.xlarge","c6a.xlarge","c6i.xlarge","c6in.xlarge","c7i.xlarge","c7i-flex.xlarge","inf1.xlarge" ]
      min_size           = 0     
      desired_size       = 0
      max_size           = 10
      launch_template_id = module.al2023-ondemand-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"  
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "spot-ng"])
      })
    }
  }
 
  # Cluster Tags
  tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "al2023-eks-cluster"])
    } )
    
}

  
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

#=================================================================================================================================================================
