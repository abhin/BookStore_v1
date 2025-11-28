variable "name" {
  description = "Name prefix for ElastiCache (Redis)"
  type        = string
}

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "engine_version" {
  type    = string
  default = "7"
}

variable "num_cache_nodes" {
  type    = number
  default = 1
}

variable "subnet_group_name" {
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
