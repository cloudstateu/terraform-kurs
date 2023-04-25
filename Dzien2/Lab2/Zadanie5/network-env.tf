module "network-prod" {
  source = "./module"
  providers = {
    azurerm.network = azurerm
  }

  vnet_name             = "vnet-prod"
  vnet_address_space    = ["10.10.0.0/16"]
  subnet1_address_space = ["10.10.0.0/24"]
  subnet2_address_space = ["10.10.1.0/24"]
  subnet3_address_space = ["10.10.2.0/24"]
  rg_name               = data.azurerm_resource_group.studentXX.name
  location              = data.azurerm_resource_group.studentXX.location
}

module "network-dev" {
  source = "./module"
  providers = {
    azurerm.network = azurerm
  }

  vnet_name             = "vnet-dev"
  vnet_address_space    = ["10.11.0.0/16"]
  subnet1_address_space = ["10.11.0.0/24"]
  subnet2_address_space = ["10.11.1.0/24"]
  subnet3_address_space = ["10.11.2.0/24"]
  rg_name               = data.azurerm_resource_group.studentXX.name
  location              = data.azurerm_resource_group.studentXX.location
}
