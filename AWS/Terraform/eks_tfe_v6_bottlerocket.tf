##############################################################################################################################################################
# EKS Cluster & Managed Node groups Module
##############################################################################################################################################################

module "bottlerocket_eks_cluster" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-eks_v6"
  create = true

  name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "bottlerocker-cluster"])
  kubernetes_version = "1.33"

  endpoint_public_access  = false
  endpoint_private_access = true

  create_cloudwatch_log_group     = false
  vpc_id                                = var.nonpcidss-prod-vpc
  #service_ipv4_cidr             = "10.211.128.0/24"
  subnet_ids              = ["${var.cp-subnet-aza}", "${var.cp-subnet-azb}", "${var.cp-subnet-azc}"]
  create_security_group = false  
  additional_security_group_ids     = ["${var.eks-cluster-workernode-sg}"]
  #security_group_id  = ["${var.eks-cluster-workernode-sg}"]
  

  create_node_security_group = false
  node_security_group_id     = var.eks-cluster-workernode-sg

  enable_irsa     = true
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::216066832707:role/hbl-aws-aps1-application-uat-eks-cluster-role"

#===========================
  # EKS Cluster Encryption
  #===========================
  create_kms_key = false
  encryption_config = {
    resources : [ "secrets" ],
    provider_key_arn = "arn:aws:kms:ap-south-1:911372318716:key/1e884af2-73cd-4132-9612-d9dd72d981e0"
  }

#cluster_encryption_config = {
  #===========================
  # EKS Managed Addons
  #===========================

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
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"
      instance_types     = [ "c6a.2xlarge" ]
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org,  local.csp, local.account, local.vpcname, local.env, "ondemand-ng"])})
    }
    spot-ng = {
       name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, "spot-ng"])
       create_iam_role    = false
       iam_role_arn = "arn:aws:iam::216066832707:role/hbl-aws-aps1-appname-uat-eks-workernode-role"
       min_size           = 0
       desired_size       = 0
       max_size           = 8
       ami_type       = "BOTTLEROCKET_x86_64"
      instance_types =["c5.2xlarge", "c5a.2xlarge", "c5d.2xlarge", "c6a.2xlarge", "c6i.2xlarge", "c6in.2xlarge", "c7i.2xlarge"]
       subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
       capacity_type      = "SPOT"
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, "spot-ng"])})
      }
    }
  
# Cluster Tags
    tags = merge({ Name = join("-",[local.org, local.csp, local.region, local.vpcname, local.env, local.account, "bottlerocker-cluster"])}, 
var.additional_tags)

	   
}
#===============================================================
#### EKS ACCESS POINT 
#=================================================================

resource "aws_eks_access_entry" "admin" {
  depends_on = [ module.bottlerocket_eks_cluster ]
  cluster_name      = "${module.bottlerocket_eks_cluster.cluster_name}"
  principal_arn     = "arn:aws:iam::216066832707:role/hbl-aws-role-tfeappinfra-sharedservices-infra-uat"
  kubernetes_groups = ["admin"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "policy" {
  depends_on = [aws_eks_access_entry.admin ]
  cluster_name  = "${module.bottlerocket_eks_cluster.cluster_name}"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::216066832707:role/hbl-aws-role-tfeappinfra-sharedservices-infra-uat"

access_scope {
    type       = "namespace"
    namespaces = ["cluster"]
  }
}
#===============================================================
#### END EKS ACCESS POINT 
#=================================================================


#=======================================================================
## VPC CNI ENI #############
#======================================================================
/*
locals { pods-subnet = { 
    "ap-south-1a" = "subnet-0c0119e95aa26d9b0",
    "ap-south-1b" = "subnet-01e7d9c383d7f8519",
    "ap-south-1c" = "subnet-09919d3d195adb829" 
}}

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
      - ${var.eks-cluster}
    subnet: ${each.value}
  YAML
}
#======================================================================
## END VPC CNI ENI #############
#======================================================================
*/
