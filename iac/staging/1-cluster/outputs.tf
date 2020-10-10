output "resource_group_name" {
  value = local.resource_group_name
}

output "cluster_name" {
  value = local.cluster_name
}

output "velero_identity_name" {
  value = local.backups_managed_identity_name
}

output "velero_identity_client_id" {
  value = module.aks_backsups.managed_identity_client_id
}

output "velero_identity_resource_id" {
  value = module.aks_backsups.managed_identity_principal_id
}