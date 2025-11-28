terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# NOTE: backend configuration is intentionally not hard-coded here.
# Run `terraform init` with `-backend-config` arguments to configure remote state (S3 + DynamoDB).

provider "aws" {
  region = var.region
}

# ECR for backend and frontend images
module "ecr_backend" {
  source = "../../modules/ecr"
  name   = "${var.name}-backend"
  tags   = var.tags
}

module "ecr_frontend" {
  source = "../../modules/ecr"
  name   = "${var.name}-frontend"
  tags   = var.tags
}

# RDS PostgreSQL database
module "rds_postgres" {
  source            = "../../modules/rds"
  name              = "${var.name}-db"
  username          = var.db_username
  password          = var.db_password
  allocated_storage = var.db_storage
  instance_class    = var.db_instance_class
  tags              = var.tags
}

# ElastiCache Redis for caching
module "redis" {
  source            = "../../modules/elasticache"
  name              = "${var.name}-redis"
  node_type         = var.redis_node_type
  num_cache_nodes   = var.redis_nodes
  tags              = var.tags
}

# AWS MSK (Kafka) for event streaming
module "kafka" {
  source                 = "../../modules/msk"
  name                   = "${var.name}-kafka"
  number_of_broker_nodes = var.kafka_brokers
  broker_instance_type   = var.kafka_instance_type
  kafka_version          = var.kafka_version
  tags                   = var.tags
}

# ECS Cluster + Service for backend
module "ecs_backend" {
  source             = "../../modules/ecs"
  name               = "${var.name}-backend"
  container_image    = var.backend_image
  container_port     = var.backend_port
  desired_count      = var.backend_desired_count
  cpu                = var.backend_cpu
  memory             = var.backend_memory
  tags               = var.tags
}

# ECS Cluster + Service for frontend
module "ecs_frontend" {
  source             = "../../modules/ecs"
  name               = "${var.name}-frontend"
  container_image    = var.frontend_image
  container_port     = var.frontend_port
  desired_count      = var.frontend_desired_count
  cpu                = var.frontend_cpu
  memory             = var.frontend_memory
  tags               = var.tags
}

# S3 for book images
module "s3_images" {
  source = "../../modules/s3"
  name   = "${var.name}-images"
  tags   = var.tags
}

# CloudWatch + Prometheus + Grafana + AlertManager monitoring
module "monitoring" {
  source = "../../modules/monitoring"
  name   = var.name
  tags   = var.tags
}
