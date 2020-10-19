resource "azurerm_user_assigned_identity" "velero_identity" {
  resource_group_name = var.node_resource_group
  location            = var.location

  name = var.identity_name
}

data "azurerm_subscription" "current" {
}

resource "azurerm_role_assignment" "contributor_role" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.velero_identity.principal_id
}