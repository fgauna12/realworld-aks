output "managed_identity_client_id" {
    value = azurerm_user_assigned_identity.velero_identity.client_id
}

output "managed_identity_resource_id" {
    value = azurerm_user_assigned_identity.velero_identity.id
}