resource "azurerm_user_assigned_identity" "cni" {
  name                = "cni-studentXX"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_user_assigned_identity" "cni_kubelet" {
  name                = "cni-kubelet-studentXX"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
}

resource "azurerm_role_assignment" "kubenet_private_dns_contributor" {
  scope                = azurerm_private_dns_zone.private_dns_zones["aks"].id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cni.principal_id
}

resource "azurerm_role_assignment" "kubenet_contributor" {
  scope                = data.azurerm_resource_group.studentXX.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.cni.principal_id
}

resource "azurerm_role_assignment" "kubenet_operator" {
  scope                = azurerm_user_assigned_identity.cni_kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.cni.principal_id
}

resource "azurerm_role_assignment" "kubenet_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.cni_kubelet.principal_id
}
