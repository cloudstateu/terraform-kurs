# https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
# https://developer.hashicorp.com/terraform/language/resources/provisioners/connection

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "example-machine"
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "testower123!@#"
  disable_password_authentication = false
  network_interface_ids           = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  #  Zalecana alternatywa dla remote-exec
  #  custom_data = filebase64("${path.module}/script.sh")

  connection {
    type     = "ssh"
    user     = self.admin_username
    password = self.admin_password
    host     = self.public_ip_address
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip_address} >> public_ip.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt upgrade -y",
      "sudo apt install nginx -y"
    ]
  }

  provisioner "file" {
    source      = "./wiadomosc.md"
    destination = "wiadomosc.md"
  }
}
