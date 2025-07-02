#terraform {
#  backend "azurerm" {}
#}
terraform { 
  cloud { 
    
    organization = "KDvops" 

    workspaces { 
      name = "devsu-dev" 
    } 
  } 
}