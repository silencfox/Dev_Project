provider "azurerm" {
  features {}
}

module "acr" {
  source                 = "../../modules/acr"
  location               = var.location
  rgname                 = var.rgname
  sku                    = var.sku
  acr_name               = var.acr_name
  create_acr             = var.create_acr
  ghpathfile             = var.ghpathfile
  TF_VAR_ghtoken         = var.TF_VAR_ghtoken
}



