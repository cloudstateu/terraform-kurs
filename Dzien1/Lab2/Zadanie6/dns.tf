locals {
  zones = {
    "acr" = "privatelink.azurecr.io"
  }
}

resource "azurerm_private_dns_zone" "acr" {
  name                = local.zones.acr
  resource_group_name = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "shared" {
  name                  = "acr-shared"
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = azurerm_virtual_network.shared.id
  resource_group_name   = data.azurerm_resource_group.studentXX.name
}
