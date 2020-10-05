resource "azurerm_storage_account" "storage_account_aks_backups" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  access_tier               = "Cool"
  min_tls_version           = "TLS1_2"
}

resource "azurerm_storage_container" "velero_container" {
  name                  = "velero"
  storage_account_name  = azurerm_storage_account.storage_account_aks_backups.name
  container_access_type = "private"
}
