
#########################################
terraform {
  required_version = ">= 1.5.7"
  required_providers {
  
  aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
      #configuration_aliases = [ aws.nwinfra ]
    }
   tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }	
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }	
    opensearch = {
      source  = "opensearch-project/opensearch"
      version = ">= 2.0"
    }	
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 1.35.0"
    }	
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.7"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  alias  = "mumbai"
}

provider "aws" {
  region = "ap-south-1"
  assume_role {
    role_arn = "arn:aws:iam::216066832707:role/hbl-aws-role-tfeappinfra-sharedservices-infra-uat"
  }
}
