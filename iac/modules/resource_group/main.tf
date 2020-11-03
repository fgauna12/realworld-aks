terraform {
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
  }
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}
