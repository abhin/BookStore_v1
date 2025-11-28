variable "name" {
  description = "MSK cluster name"
  type        = string
}

variable "kafka_version" {
  type    = string
  default = "2.8.1"
}

variable "broker_instance_type" {
  type    = string
  default = "kafka.m5.large"
}

variable "number_of_broker_nodes" {
  type    = number
  default = 1
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
