#flux namespace

terraform {
  required_providers {
    kubernetes = {
      version = "~> 1.13.2"
    }
    helm = {
      version = "~> 1.3.0"
    }
  }
}

resource "kubernetes_namespace" "flux_namespace" {
  metadata {
    name = var.flux_namespace
  }
}

#kubernetes crds are not supported using the kubernetes provider

#flux
# helm upgrade -i flux fluxcd/flux \                     
#    --set git.url=git@github.com:fgauna12/realworld-aks.git \        
#    --set git.path=k8s --namespace flux
resource "helm_release" "flux" {
  name       = "flux"
  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  version    = var.flux_version
  namespace  = var.flux_namespace

  set {
    name  = "git.url"
    value = var.git_url
  }

  set {
    name  = "git.path"
    value = var.git_path
  }
}

#helm operator

# helm upgrade -i helm-operator fluxcd/helm-operator \   
#    --set helm.versions=v3 --set git.ssh.secretName=flux-git-deploy \
#    --namespace flux
resource "helm_release" "helm_operator" {
  name       = "helm-operator"
  repository = "https://charts.fluxcd.io"
  chart      = "helm-operator"
  version    = var.flux_version
  namespace  = var.flux_namespace

  set {
    name  = "helm.versions"
    value = "v3"
  }

  set {
    name  = "git.ssh.secretName"
    value = "flux-git-deploy"
  }
}

