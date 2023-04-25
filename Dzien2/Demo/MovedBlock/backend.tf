terraform {
  backend "azurerm" {
    storage_account_name = "stgstudent0state"
    container_name       = "tfstate"
    key                  = "movedblocks/szkolenietf"
    use_azuread_auth     = true
    subscription_id      = "b82ba90e-f032-4013-8090-e31e88e71ed8"
    tenant_id            = "3a81269f-0731-42d7-9911-a8e9202fa750"
  }
}