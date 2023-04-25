resource "azurerm_virtual_network" "env" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network_peering" "env" {
  name                      = "peer-${var.vnet_name}-to-shared"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.env.name
  remote_virtual_network_id = "----vnet-shared-ID------"
}

resource "azurerm_virtual_network_peering" "shared" {
  name                      = "peer-shared-to-${var.vnet_name}"
  resource_group_name       = var.rg_name
  virtual_network_name      = "----vnet-shared-name------"
  remote_virtual_network_id = azurerm_virtual_network.env.id
}

resource "azurerm_subnet" "app" {
  name                 = "sbn-app"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.env.name
  address_prefixes     = var.subnet1_address_space
}

resource "azurerm_subnet" "endpoint" {
  name                 = "sbn-endpoint"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.env.name
  address_prefixes     = var.subnet2_address_space
}

resource "azurerm_subnet" "data" {
  name                 = "sbn-data"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.env.name
  address_prefixes     = var.subnet3_address_space

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "nsg-app-${var.vnet_name}"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

resource "azurerm_network_security_group" "endpoint" {
  name                = "nsg-endpoint-${var.vnet_name}"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "endpoint" {
  subnet_id                 = azurerm_subnet.endpoint.id
  network_security_group_id = azurerm_network_security_group.endpoint.id
}

resource "azurerm_network_security_group" "data" {
  name                = "nsg-data-${var.vnet_name}"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "data" {
  subnet_id                 = azurerm_subnet.data.id
  network_security_group_id = azurerm_network_security_group.data.id
}