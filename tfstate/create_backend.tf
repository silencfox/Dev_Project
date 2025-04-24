provider "azurerm" {
  features {
  }
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}


resource "azurerm_resource_group" "tfstate" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storeacount  # debe ser único globalmente
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location

  account_tier             = "Standard"      # Más económico
  account_replication_type = "LRS"           # Sin replicación externa

  tags = {
    environment = "terraform-state"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
