terraform {
  backend "azurerm" {
    storage_account_name = "xxx"
    container_name       = "tfstate"
    key                  = "terraform-state-file"

    use_azuread_auth     = true
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    tenant_id            = "00000000-0000-0000-0000-000000000000"
  }
}
