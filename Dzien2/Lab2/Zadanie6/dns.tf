locals {
  zones = {
    "file"       = "privatelink.file.core.windows.net"
    "postgresql" = "privatelink.postgres.database.azure.com"
    "aks"        = "privatelink.${data.azurerm_resource_group.studentXX.location}.azmk8s.io"
    "acr"        = "privatelink.azurecr.io"
    "kv"         = "privatelink.vaultcore.azure.net"
  }
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
  for_each = local.zones

  name                = each.value
  resource_group_name = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "shared" {
  for_each = local.zones

  name                  = "${each.key}-shared"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zones[each.key].name
  virtual_network_id    = azurerm_virtual_network.shared.id
  resource_group_name   = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dev" {
  for_each = local.zones

  name                  = "${each.key}-dev"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zones[each.key].name
  virtual_network_id    = module.network-dev.network.id
  resource_group_name   = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "prod" {
  for_each = local.zones

  name                  = "${each.key}-prod"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zones[each.key].name
  virtual_network_id    = module.network-prod.network.id
  resource_group_name   = data.azurerm_resource_group.studentXX.name
}
