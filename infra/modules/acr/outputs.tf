output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "container_registry_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "container_registry_resource_group" {
  value = azurerm_container_registry.acr.resource_group_name
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
}