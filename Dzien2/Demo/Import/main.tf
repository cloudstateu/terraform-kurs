
// Przykładowa reprezentacja zasobu
resource "azurerm_key_vault" "vault" {
  name                        = "chmstudent0toimport"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  tags = {
    "Creator" = "Dawid"
  }
}


// Import przy pomocy
// terraform import azurerm_key_vault.value ___TUTAJ_ID_ZASOBU___
