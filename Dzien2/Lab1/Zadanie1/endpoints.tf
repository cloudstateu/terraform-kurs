resource "azurerm_private_endpoint" "acr" {
  name                = "endpoint-acr"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
  subnet_id           = azurerm_subnet.shared-endpoints.id

  private_service_connection {
    name                           = "connection-acr"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.private_dns_zones["acr"].name
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones["acr"].id]
  }
}