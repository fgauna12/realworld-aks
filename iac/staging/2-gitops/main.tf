terraform {
  backend "azurerm" {
    storage_account_name = "stterraformstg001"
    container_name       = "realworld"
    key                  = "staging-gitops.terraform.tfstate"
  }
}

locals {

}

module "cluster" {
  source = "../../modules/flux"

  flux_namespace = "flux"
  git_url = "git@github.com:fgauna12/realworld-aks.git"
  git_path = "k8s"
}
