provider "azurerm" {
  features {
  }
}


resource "azurerm_resource_group" "tfstate" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storeacount 
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location

  account_tier             = "Standard"     
  account_replication_type = "LRS"           

  tags = {
    environment = "terraform-state"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}
