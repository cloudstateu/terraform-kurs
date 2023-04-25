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

resource "azurerm_private_endpoint" "kv" {
  name                = "enpoint-kv"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
  subnet_id           = module.network-dev.sbn-endpoint.id

  private_service_connection {
    name                           = "connection-kv"
    private_connection_resource_id = azurerm_key_vault.chmstudentXXkv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.private_dns_zones["kv"].name
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones["kv"].id]
  }
}

resource "azurerm_private_endpoint" "file" {
  name                = "enpoint-stg"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
  subnet_id           = module.network-dev.sbn-endpoint.id

  private_service_connection {
    name                           = "connection-stg"
    private_connection_resource_id = azurerm_storage_account.stgstudentXXkurstf.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.private_dns_zones["file"].name
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones["file"].id]
  }
}