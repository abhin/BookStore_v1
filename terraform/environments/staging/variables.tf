variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "bookstore-staging"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Environment = "staging"
    Project     = "BookStore"
  }
}

variable "backend_image" {
  type    = string
  default = ""
}

variable "backend_port" {
  type    = number
  default = 8080
}

variable "backend_desired_count" {
  type    = number
  default = 2
}

variable "backend_cpu" {
  type    = string
  default = "512"
}

variable "backend_memory" {
  type    = string
  default = "1024"
}

variable "frontend_image" {
  type    = string
  default = ""
}

variable "frontend_port" {
  type    = number
  default = 3000
}

variable "frontend_desired_count" {
  type    = number
  default = 2
}

variable "frontend_cpu" {
  type    = string
  default = "512"
}

variable "frontend_memory" {
  type    = string
  default = "1024"
}

variable "db_username" {
  type      = string
  default   = "postgres"
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_storage" {
  type    = number
  default = 50
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "redis_node_type" {
  type    = string
  default = "cache.t3.small"
}

variable "redis_nodes" {
  type    = number
  default = 2
}

variable "kafka_brokers" {
  type    = number
  default = 2
}

variable "kafka_instance_type" {
  type    = string
  default = "kafka.m5.large"
}

variable "kafka_version" {
  type    = string
  default = "2.8.1"
}
