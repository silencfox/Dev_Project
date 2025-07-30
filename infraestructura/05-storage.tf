resource "random_integer" "this" {
  min = 10000
  max = 5000000
}

resource "azurerm_storage_account" "this" {
  name                     = "devtest${random_integer.this.result}"
  resource_group_name      = "${var.rgname}-${var.environment}"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "test"
  #storage_account_name  = azurerm_storage_account.this.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "dev_test" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.dev_test.principal_id
}
