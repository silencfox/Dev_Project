terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devsu-tfstate"
    storage_account_name = "tfdevsublobstorage007011"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
