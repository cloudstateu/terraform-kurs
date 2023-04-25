resource "azurerm_virtual_network" "shared" {
  name                = "${var.vnet_name}-${local.prefix}"
  address_space       = var.vnet_address_space
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_subnet" "shared-endpoints" {
  name                 = "${var.subnet_name}-${local.prefix}"
  resource_group_name  = data.azurerm_resource_group.studentXX.name
  virtual_network_name = azurerm_virtual_network.shared.name
  address_prefixes     = var.subnet_address_prefixes
}