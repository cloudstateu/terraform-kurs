# Zadanie: Dynamic Blocks

Przygotuj nową konfigurację terraform wraz z data source pobierającym przypisaną do
Ciebie grupę zasobów.

Dodaj także date source `azurerm_client_config` pobierający aktualną konfigurację providera.

Utwórz zasób Azure Key Vault i skonfiguruj w nim Access Policy z wykorzystaniem dynamic blocks i zmiennej lokalnej:

```terraform
locals {
  vault_access_policy : {
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
```

Wartość `tenant_id` przy konfiguracji pobierz z data `azurerm_client_config`.

Pomocne linki:

* [Dokumentacja Dynamic Blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)
* [Dokumentacja Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
