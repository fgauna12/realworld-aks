terraform {
  required_providers {
    azurerm = {
      version = "~>2.30"
    }
  }
}

variable "app_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "location" {
  type = string
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.app_name}-${var.environment_name}-001"
  location = var.location
}

output "name" {
  type = string
}

