output "sbn-endpoint" {
  value = azurerm_subnet.endpoint
}

output "sbn-data" {
  value = azurerm_subnet.data
}

output "sbn-app" {
  value = azurerm_subnet.app
}

output "network" {
  value = azurerm_virtual_network.env
}