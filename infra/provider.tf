terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~> 3.0.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }

  }

  required_version = ">= 1.9.0"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}
provider "azuread" {
  
}


provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config["host"]
    client_certificate     = base64decode(module.aks.kube_config["client_certificate"])
    client_key             = base64decode(module.aks.kube_config["client_key"])
    cluster_ca_certificate = base64decode(module.aks.kube_config["cluster_ca_certificate"])
  }
}
