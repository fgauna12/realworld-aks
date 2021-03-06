terraform {
  backend "azurerm" {
    storage_account_name = "stterraformstg001"
    container_name       = "realworld"
    key                  = "staging.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
    azuread = {
      version = "~>0.11"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {

}

locals {
  environment_name              = "staging"
  resource_group_name           = "rg-realworld-${local.environment_name}-001"
  storage_account_name          = "strwbackups${local.environment_name}001"
  cluster_name                  = "azaks-realworld-${local.environment_name}-001"
  location                      = "eastus"
  node_count                    = 3
  backups_managed_identity_name = "${local.cluster_name}-velero"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_group_name
  location = local.location
}

module "cluster" {
  source = "../../modules/aks-cluster"

  location                 = local.location
  node_count               = local.node_count
  environment              = local.environment_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  cluster_name             = local.cluster_name
  dns_prefix               = local.cluster_name
  enable_acr               = false
  disable_role_assignments = false
}

module "aks_backups" {
  source = "../../modules/aks-backups"

  location               = local.location
  resource_group_name    = azurerm_resource_group.resource_group.name
  storage_account_name   = local.storage_account_name
  storage_container_name = "backups-${local.cluster_name}"
  identity_name          = local.backups_managed_identity_name
  node_resource_group    = module.cluster.node_resource_group
}

