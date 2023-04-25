variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet1_address_space" {
  type = list(string)
}

variable "subnet2_address_space" {
  type = list(string)
}

variable "subnet3_address_space" {
  type = list(string)
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}