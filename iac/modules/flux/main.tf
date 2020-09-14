#flux namespace

#kubernetes crds

#flux

#helm operator
resource "helm_release" "helm_operator" {
  name       = "helm-operator"
  repository = "https://kubernetes-charts.storage.googleapis.com" 
  chart      = "redis"
  version    = "6.0.1"

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set_string {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
  }
}

# helm upgrade -i helm-operator fluxcd/helm-operator \   
#    --set helm.versions=v3 --set git.ssh.secretName=flux-git-deploy \
#    --namespace flux
