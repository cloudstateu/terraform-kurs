resource "azurerm_storage_account" "stgstudentXXkurstf" {
  name                     = "stgstudentXXkurstf"
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  location                 = data.azurerm_resource_group.studentXX.location
  resource_group_name      = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_storage_share" "filestudentXXkurstf" {
  name                 = "filestudentXXkurstf"
  storage_account_name = azurerm_storage_account.stgstudentXXkurstf.name
  quota                = 50
}