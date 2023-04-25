# resource "azurerm_virtual_network" "classic" {
#   name                = "vnet-classic"
#   address_space       = ["10.2.0.0/24"]
#   location            = data.azurerm_resource_group.student0.location
#   resource_group_name = data.azurerm_resource_group.student0.name
# }

module "network-prod" {
  source = "./module"
  providers = {
    azurerm.network = azurerm
  }

  vnet_name             = "vnet-classic"
  vnet_address_space    = ["10.2.0.0/24"]
  rg_name               = data.azurerm_resource_group.student0.name
  location              = data.azurerm_resource_group.student0.location
}

# moved {
#   from = azurerm_virtual_network.classic
#   to = module.network-prod.azurerm_virtual_network.env
# }