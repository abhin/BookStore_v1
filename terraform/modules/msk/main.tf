# Minimal MSK cluster. MSK requires subnets in at least 2 AZs for production.
resource "aws_msk_cluster" "this" {
  cluster_name = var.name
  kafka_version = var.kafka_version

  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type = var.broker_instance_type
    client_subnets = var.subnet_ids
    security_groups = var.security_groups
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
      in_cluster    = true
    }
  }

  tags = var.tags
}
