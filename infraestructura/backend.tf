#terraform {
#  backend "azurerm" {}
#}
#terraform { 
#  cloud { 
    
#    organization = "KDvops" 

#    workspaces { 
#      name = "devsu-dev" 
#    } 
#  } 
#}


terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
