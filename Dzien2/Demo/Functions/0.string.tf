locals {
  resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg_name/providers/Microsoft.Storage/storageAccounts/storagename"
  id_table    = split("/", local.resource_id)

  location            = " West Europe"
  lower_location      = lower(local.location)
  trim_lower_location = trimspace(local.lower_location)

  nospace_location = lower(replace(local.location, "/\\s+/", ""))
}
