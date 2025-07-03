output "kube_config2" {
    value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  
}

output "kube_config" {
  value = {
    host                   = azurerm_kubernetes_cluster.aks-cluster.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.aks-cluster.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.aks-cluster.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.aks-cluster.kube_config[0].cluster_ca_certificate
  }
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