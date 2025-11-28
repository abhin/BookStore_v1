variable "name" {
  type = string
}

variable "port" {
  type    = number
  default = 9090
}

variable "tags" {
  type    = map(string)
  default = {}
}
