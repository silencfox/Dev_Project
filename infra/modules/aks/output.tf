output "kube_config" {
    value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  
}

output "aks_principal_id" {
  value = azurerm_kubernetes_cluster.aks-cluster.identity[0].principal_id
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks-cluster.id
}


output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks-cluster.kubelet_identity
}