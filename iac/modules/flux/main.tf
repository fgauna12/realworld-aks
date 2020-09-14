#flux namespace

terraform {
  required_providers {
    kubernetes = {
      version = "~> 1.13.2"
    }
  }
}

resource "kubernetes_namespace" "flux_namespace" {
  metadata {
    name = var.flux_namespace
  }
}

#kubernetes crds

#flux
# helm upgrade -i flux fluxcd/flux \                     
#    --set git.url=git@github.com:fgauna12/realworld-aks.git \        
#    --set git.path=k8s --namespace flux
# resource "helm_release" "helm_operator" {
#   name       = "helm-operator"
#   repository = "https://kubernetes-charts.storage.googleapis.com" 
#   chart      = "redis"
#   version    = "6.0.1"

#   values = [
#     "${file("values.yaml")}"
#   ]

#   set {
#     name  = "cluster.enabled"
#     value = "true"
#   }

#   set {
#     name  = "metrics.enabled"
#     value = "true"
#   }

#   set_string {
#     name  = "service.annotations.prometheus\\.io/port"
#     value = "9127"
#   }
# }

#helm operator

# helm upgrade -i helm-operator fluxcd/helm-operator \   
#    --set helm.versions=v3 --set git.ssh.secretName=flux-git-deploy \
#    --namespace flux
# resource "helm_release" "helm_operator" {
#   name       = "helm-operator"
#   repository = "https://kubernetes-charts.storage.googleapis.com" 
#   chart      = "redis"
#   version    = "6.0.1"

#   values = [
#     "${file("values.yaml")}"
#   ]

#   set {
#     name  = "cluster.enabled"
#     value = "true"
#   }

#   set {
#     name  = "metrics.enabled"
#     value = "true"
#   }

#   set_string {
#     name  = "service.annotations.prometheus\\.io/port"
#     value = "9127"
#   }
# }

