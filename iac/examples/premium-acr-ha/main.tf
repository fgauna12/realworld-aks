# Premium Azure Container Registry with Geo-Replication

terraform {
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "random" {
  length  = 8
  special = false
}

variable "location" {
  default = "eastus"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-examples-premiumacr-${random_string.random.result}-001"
  location = var.location
}

module "acr" {
  source = "../../modules/acr"

  location                 = var.location
  resource_group_name      = azurerm_resource_group.resource_group.name
  container_registry_name  = "ContosoRegistry${random_string.random.result}"
  container_registry_sku   = "Premium"
  georeplication_locations = ["West US", "Central US"]
}
