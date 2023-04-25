#https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info
#https://developer.hashicorp.com/terraform/language/functions/file
#https://developer.hashicorp.com/terraform/language/functions/jsondecode

locals {
  raw_json = file("${path.module}/2.json")
  json = jsondecode(local.raw_json)
}

output "json" {
  value = local.json
}

resource "azurerm_storage_account" "example" {
  name                     = local.json.name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = local.json.account_tier
  account_replication_type = local.json.account_replication_type

  tags = {
    environment = "staging"
  }
}
