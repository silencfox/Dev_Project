output "storage_account" {
  value = azurerm_storage_account.tfstate.name
}

output "storage_container" {
  value = azurerm_storage_container.tfstate.name
}


