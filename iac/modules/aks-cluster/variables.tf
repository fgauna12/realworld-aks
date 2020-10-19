variable "cluster_name" {

}

variable "resource_group_name" {

}

variable "environment" {

}

variable "location" {
  default = "East US"
}

variable "node_count" {
  default = 3
}

variable "node_size" {
  default = "Standard_D2_v2"
}

variable dns_prefix {
  
}

variable "enable_acr" {
  type = bool
}

variable "disable_role_assignments" {
  type = bool
  default = false
}

variable "acr_resource_id" {
  default = ""
}

variable "kubernetes_version" {
  type = string
  default = "1.18.6"
}



