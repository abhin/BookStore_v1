variable "name" {
  description = "Name prefix for ECR repository"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
