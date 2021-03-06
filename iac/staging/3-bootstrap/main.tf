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

resource "kubernetes_manifest" "velero_azure_identity_exception" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "aadpodidentity.k8s.io/v1"
    "kind"       = "AzurePodIdentityException"
    "metadata" = {
      "name"      = "system-pods-exception"
      "namespace" = "kube-system"
    }
    "spec" = {
      "podLabels" = {
        "kubernetes.azure.com/managedby" = "aks"
      }
    }
  }

}

resource "kubernetes_manifest" "velero_azure_identity" {
  provider = kubernetes-alpha

  manifest = {
    apiVersion = "aadpodidentity.k8s.io/v1"
    kind       = "AzureIdentity"
    metadata = {
      name      = var.identity_name
      namespace = "kube-system"
    }
    spec = {
      clientID   = var.identity_client_id
      resourceID = var.identity_resource_id
      type       = 0
    }
  }
}

resource "kubernetes_manifest" "velero_azure_identity_binding" {
  provider = kubernetes-alpha

  manifest = {
    apiVersion = "aadpodidentity.k8s.io/v1"
    kind       = "AzureIdentityBinding"
    metadata = {
      name      = "${var.identity_name}-binding"
      namespace = "kube-system"
    }
    spec = {
      azureIdentity = var.identity_name
      selector      = "velero"
    }
  }
}

