resource "azurerm_user_assigned_identity" "user_aid_aks" {
  name                  = local.user_aid_name
  resource_group_name   = azurerm_resource_group.rg_aks.name
  location              = azurerm_resource_group.rg_aks.location

  tags = {
    environment = azurerm_resource_group.rg_aks.tags.environment
  }
}

resource "azurerm_role_assignment" "network_contributor_aks" {
  scope                 = azurerm_resource_group.rg_aks.id
  #role_definition_name  = "Network Contributor"
  role_definition_name  = "Azure Kubernetes Service Cluster User Role"
  principal_id          = azurerm_user_assigned_identity.user_aid_aks.principal_id
}