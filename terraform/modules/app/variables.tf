variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC id where resources will be deployed"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnet ids for ALB and ECS tasks"
  type        = list(string)
  default     = []
}

variable "container_image" {
  description = "Container image URI to run (ECR or public)"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "Task CPU units"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Task memory"
  type        = string
  default     = "512"
}

variable "enable_rds" {
  description = "Whether to create an RDS instance for the app"
  type        = bool
  default     = false
}

variable "db_allocated_storage" {
  description = "RDS allocated storage (GB)"
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "bookstore"
}

variable "db_password" {
  description = "RDS master password"
  sensitive   = true
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
