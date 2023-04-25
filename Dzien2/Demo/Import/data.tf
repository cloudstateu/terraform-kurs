data "azurerm_resource_group" "rg" {
  name = "__TWOJA_GRUPA_ZASOBÓW__"
}

data "azurerm_client_config" "current" {}
