variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "bookstore-dev"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "BookStore"
  }
}

# ECR & Backend Service
variable "backend_image" {
  description = "Backend Docker image URI"
  type        = string
  default     = ""
}

variable "backend_port" {
  type    = number
  default = 8080
}

variable "backend_desired_count" {
  type    = number
  default = 1
}

variable "backend_cpu" {
  type    = string
  default = "256"
}

variable "backend_memory" {
  type    = string
  default = "512"
}

# Frontend Service
variable "frontend_image" {
  description = "Frontend Docker image URI"
  type        = string
  default     = ""
}

variable "frontend_port" {
  type    = number
  default = 3000
}

variable "frontend_desired_count" {
  type    = number
  default = 1
}

variable "frontend_cpu" {
  type    = string
  default = "256"
}

variable "frontend_memory" {
  type    = string
  default = "512"
}

# RDS PostgreSQL
variable "db_username" {
  type      = string
  default   = "postgres"
  sensitive = true
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_storage" {
  type    = number
  default = 20
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

# ElastiCache Redis
variable "redis_node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "redis_nodes" {
  type    = number
  default = 1
}

# MSK Kafka
variable "kafka_brokers" {
  type    = number
  default = 1
}

variable "kafka_instance_type" {
  type    = string
  default = "kafka.t3.small"
}

variable "kafka_version" {
  type    = string
  default = "2.8.1"
}
