
resource "azurerm_resource_group" "tfstate" {
  name     = var.state_rgname
  location = var.location
}


resource "azurerm_storage_account" "tfstate" {
  name                     = var.storeacount 
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = var.location

  account_tier             = "Standard"     
  account_replication_type = "LRS"           
  account_kind			   = "Storage"
  large_file_share_enabled = false

  blob_properties {
    delete_retention_policy {
      permanent_delete_enabled = true
    }
  }
  tags = {
    environment = "terraform-state"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}