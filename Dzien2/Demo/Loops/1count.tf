# condition ? true_val : false_val

variable "vnet_creation" {
  type    = bool
  default = false
}

resource "azurerm_virtual_network" "vnet-hub" {
  count               = var.vnet_creation == true ? 1 : 0
  name                = "vnet-hub"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  address_space       = var.vnet_hub_address_space
}

locals {
  vnet = azurerm_virtual_network.vnet-hub[0]
}
