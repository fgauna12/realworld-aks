terraform {
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
  }
}

resource "azurerm_container_registry" "acr" {
  name                     = var.container_registry_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.container_registry_sku
  admin_enabled            = false
  georeplication_locations = var.georeplication_locations
}
