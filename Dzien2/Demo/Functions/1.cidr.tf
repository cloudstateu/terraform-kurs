# https://developer.hashicorp.com/terraform/language/functions/cidrsubnet
# https://developer.hashicorp.com/terraform/language/functions/length

locals {
  vnet_address    = "10.0.0.0/21"
  app_subnet      = cidrsubnet(local.vnet_address, 3, 0)
  data_subnet     = cidrsubnet(local.vnet_address, 3, 1)
  endpoint_subnet = cidrsubnet(local.vnet_address, 3, 2)
}

output "addresses" {
  value = {
    "app_subnet" = local.app_subnet
    "data_subnet" = local.data_subnet
    "endpoint_subnet" = local.endpoint_subnet
  }
}
