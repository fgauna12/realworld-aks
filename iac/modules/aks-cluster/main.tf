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

resource "azurerm_role_assignment" "acrpull_role" {
  count                = var.enable_acr ? 1 : 0
  scope                = var.acr_resource_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

