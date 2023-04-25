variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address_prefixes" {
  type = list(string)
}

locals {
  prefix = "student0"
}