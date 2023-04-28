module "ubuntu" {
  source              = "Azure/compute/azurerm"
  resource_group_name = data.azurerm_resource_group.studentXX.name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = azurerm_subnet.shared-endpoints.id
  vm_size             = "Standard_D2as_v5"

  
  enable_ssh_key = true

  remote_port  = 22
}