provider "azurerm" {
  features {
  }
}


module "ablobs" {
  source                 = "../../modules/ablobs"
  location               = var.location
  storeacount            = var.storeacount

}


