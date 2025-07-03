output "resource_group_name" {
  value = azurerm_resource_group.rg1.name
}

output "kube_config" {
  description = "config de kubernetes"
  value       = module.aks.kube_config
  sensitive = true
}

output "kube_config2" {
  description = "config de kubernetes"
  value       = module.aks.kube_config2
  sensitive = true
}

output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "acr" {
  value = module.acr.acr_id
}

output "svc_01" {
  description = "ip load balance svc aks devsu"
  value       = module.helm.lb_ip_svc01
}

output "svc_02" {
  description = "ip load balance svc aks devsu"
  value       = module.helm.lb_ip_svc02
}
