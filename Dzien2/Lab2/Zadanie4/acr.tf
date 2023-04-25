resource "azurerm_container_registry" "acr" {
  name                          = "acr${local.prefix}"
  resource_group_name           = data.azurerm_resource_group.studentXX.name
  location                      = data.azurerm_resource_group.studentXX.location
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
