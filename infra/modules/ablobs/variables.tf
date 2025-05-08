#variable "tenant_id" {}
#variable "subscription_id" {}
#variable "client_id" {}
#variable "client_secret" {}

variable "location" {
  type    = string
  default = "brazilsouth"
}

variable "state_rgname" {
  type        = string
  description = "resource group name"
  default = "rg-devsu-tfstate"
}

variable "storeacount" {
  type        = string
  description = "storage account name"
  default = "tfdevsublobstorage007011"
}

variable "rgname" {
  type        = string
  description = "resource group name"

}



variable "service_principal_name" {
  type = string
  default = ""
}

variable "keyvault_name" {
  type = string
  default = ""
}


variable "aks_name" {
  type = string
  default = ""
}

variable "sku" {
  type = string
  default = ""
}

variable "acr_name" {
  type = string
  default = ""
}

variable "create_acr" {
  type    = bool
  default = true
}

variable "ghpathfile" {
  type = string
  default = ""
}

variable "TF_VAR_ghtoken" {
  type = string
  default = ""
}

variable "environment" {
  type = string
  default = ""
  description = "Ambiente de la infra Dev, QA, Prod"
}

variable "cluster_name" {
  type = string
  default = "Devsu-aks-cluster"
  description = "Nombre del cluster AKS"
}
