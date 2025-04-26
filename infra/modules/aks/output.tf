output "kube_config" {
    value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  
}

output "aks_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}