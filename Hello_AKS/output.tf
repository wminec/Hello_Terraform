output "resource_group_name" {
  value = azurerm_resource_group.rg_aks.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_main.name
}



#output "kube_config" {
#  value       = azurerm_kubernetes_cluster.AAAAA.kube_config_raw
#  description = "kubeconfig for kubectl access."
#  sensitive   = true
#}