output "resource_group_name" {
  value = azurerm_resource_group.rg1.name
}

output "new_client_id" {
  value       = module.ServicePrincipal.client_id
}

output "client_secret" {
  value       = module.ServicePrincipal.client_secret
  sensitive = true
}

output "kube_config" {
  description = "config de kubernetes"
  value       = module.aks.kube_config
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
  value = data.azurerm_container_registry.acr.id
}

