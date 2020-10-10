resource "azurerm_user_assigned_identity" "velero_identity" {
  resource_group_name = var.node_resource_group
  location            = var.location

  name = var.identity_name
}