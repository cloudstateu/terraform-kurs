resource "azurerm_postgresql_flexible_server" "studentXX" {
  name                = "psqlflexibleserver-studentXX"
  resource_group_name = data.azurerm_resource_group.studentXX.name
  location            = data.azurerm_resource_group.studentXX.location

  delegated_subnet_id = module.network-dev.sbn-data.id
  private_dns_zone_id = azurerm_private_dns_zone.private_dns_zones["postgresql"].id

  administrator_login    = "azureuser"
  administrator_password = "mojehaslo123!"

  sku_name   = "B_Standard_B1ms"
  version    = "12"
  storage_mb = 32768
  zone       = "1"
}
