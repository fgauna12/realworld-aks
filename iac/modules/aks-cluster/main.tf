terraform {
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
  }
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  kubernetes_version = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}

data "azurerm_resource_group" "node_resource_group" {
  name = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

resource "azurerm_role_assignment" "acrpull_role" {
  count                = var.enable_acr ? 1 : 0
  scope                = var.acr_resource_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

# Giving cluster contributor rights over its own resource group
resource "azurerm_role_assignment" "contributor_role_over_nodepool_resource_group" {
  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].principal_id
}