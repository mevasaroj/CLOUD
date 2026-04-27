############################################################################################################
#================= START OF MANAGED MSK KAFKA CLUSTER ====================================================
#=========================================================================================================
module "msk_cluster" {
  source  = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-msk-kafka-cluster"

  name  = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "msk-cluster"])
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 3
  enhanced_monitoring    = "PER_TOPIC_PER_PARTITION"

  broker_node_client_subnets = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]
  broker_node_connectivity_info = {
    public_access = {
      type = "DISABLED"
    }
    vpc_connectivity = {
      client_authentication = {
        tls = false
        sasl = {
          iam   = false
          scram = true
        }
      }
    }
  }
  broker_node_instance_type   = "kafka.m7g.large"
  broker_node_security_groups = [var.kafka-sg]
  broker_node_storage_info = {
    ebs_storage_info = { volume_size = 100 }
  }

  vpc_connections = {
    connection_one = {
      authentication  = "SASL_SCRAM"
      vpc_id          = var.nonpcidss-prod-vpc
      client_subnets  = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]
      security_groups = [var.kafka-sg]
    }
  }

  encryption_in_transit_client_broker = "TLS"
  encryption_in_transit_in_cluster    = true
  encryption_at_rest_kms_key_arn = "arn:aws:kms:ap-south-1:911372318716:key/mrk-2b18f10d9eb6492a9e008a84f21b941d"

  configuration_name        = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "config"])
  configuration_description = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "config"])
  configuration_server_properties = {
    "auto.create.topics.enable" = true
    "delete.topic.enable"       = true
  }

  jmx_exporter_enabled    = true
  node_exporter_enabled   = true
  cloudwatch_logs_enabled = false
  s3_logs_enabled         = true
  s3_logs_bucket          = "hbl-aws-aps1-nonpcidss-uat-crb-log-bucket"
  s3_logs_prefix          = "msk-kafka"

  scaling_max_capacity = 512
  scaling_target_value = 80

  client_authentication = {
    sasl = { scram = true }
  }

  create_cluster_policy = false
  enable_storage_autoscaling = false

  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "msk-kafka-cluster"]) }, var.crb_tags )


}

#=========================================================================================================
#================= END OF MANAGED MSK KAFKA CLUSTER ====================================================
############################################################################################################
