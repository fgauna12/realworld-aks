terraform {
  required_providers {
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "0.2.1"
    }
  }
}

variable "identity_name" {
    type = string
}

variable "identity_client_id" {
    type = string
}

variable "identity_resource_id" {
    type = string
}

provider "kubernetes-alpha" {
  # Configuration options
  config_path = "~/.kube/config" // path to kubeconfig
}

resource "kubernetes_manifest" "azure_identity" {
  provider = kubernetes-alpha

  manifest = {
    apiVersion = "aadpodidentity.k8s.io/v1"
    kind       = "AzureIdentity"
    metadata = {
      name = var.identity_name
    }
    spec = {
      clientID   = var.identity_client_id
      resourceID = var.identity_resource_id
      type       = 0
    }
  }
}

resource "kubernetes_manifest" "azure_identity_binding" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "aadpodidentity.k8s.io/v1"
    "kind"       = "AzureIdentityBinding"
    "metadata" = {
      "name" = "${var.identity_name}-binding"
    }
    "spec" = {
      "azureIdentity" = var.identity_name
      "selector"      = var.identity_name
    }
  }
}

