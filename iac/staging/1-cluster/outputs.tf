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
  value = module.aks_backups.managed_identity_client_id
}

output "velero_identity_resource_id" {
  value = module.aks_backups.managed_identity_resource_id
}

output "node_resource_group" {
  value = module.cluster.node_resource_group
}

output "kubelet_identities" {
  value = module.cluster.kubelet_identities
}