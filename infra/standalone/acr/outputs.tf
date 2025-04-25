#output "resource_group_name" {
#  value = azurerm_resource_group.rg.name
#}

output "container_registry_name" {
  value = module.acr.container_registry_name
}

output "container_registry_login_server" {
  value = module.acr.container_registry_login_server
}

