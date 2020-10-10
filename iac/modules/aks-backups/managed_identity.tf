resource "azurerm_user_assigned_identity" "velero_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = var.identity_name
}