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

variable "tags" {
  type = map
  default = {}
}

locals {
  name = "rg-${var.app_name}-${var.environment_name}-001"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.name
  location = var.location
  tags = var.tags
}

output "resource_group_name" {
  value = local.name
}

