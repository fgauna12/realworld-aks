terraform {
  backend "azurerm" {
    storage_account_name = "stterraformstg001"
    container_name       = "realworld"
    key                  = "staging-gitops.terraform.tfstate"
  }
}

locals {
  
}

