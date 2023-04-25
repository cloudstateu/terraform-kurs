locals {
  vault_access_policy = {
    chmstudent0 = {
      object_id          = "ea3c2cef-72c7-41b2-9099-84d9fe95fdaf"
      secret_permissions = ["Get", "List", "Set"]
    }
    chmstudent29 = {
      object_id          = "e84deb1e-45bb-488a-be1b-46c3b50494b5"
      secret_permissions = ["Get", "List", "Set"]
    }
    myuser = {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
    }
  }
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = data.azurerm_resource_group.student0.location
  resource_group_name         = data.azurerm_resource_group.student0.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  dynamic "access_policy" {
    for_each = local.vault_access_policy
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = access_policy.value.object_id

      secret_permissions = access_policy.value.secret_permissions
    }
  }
}
