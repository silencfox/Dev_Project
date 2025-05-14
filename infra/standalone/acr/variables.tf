 variable "acr_rgname" {
  type        = string
  default     = "Devsu_acr"
  description = "container registry resource group name"
 }
variable "TF_VAR_ghtoken" {
  type        = string
  description = "Github persnal access token"
}

variable "ghpathfile" {
  type        = string
  default     = "https://github.com/silencfox/Dev_Project#main:app"
  description = "Github persnal access token"
}

 variable "location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

 variable "sku" {
  type        = string
  default     = "Basic"
  description = "farming capacity"
 }

 variable "acr_name" {
  type        = string
  description = "container registry name"
 }

variable "create_acr" {
  type    = bool
  default = true
}

###########################
variable "aks_rgname" {
  type        = string
  description = "resource group name"

}

variable "service_principal_name" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "environment" {
  type = string
  description = "Ambiente de la infra Dev, QA, Prod"
}

variable "cluster_name" {
  type = string
  default = "Devsu-aks-cluster"
  description = "Nombre del cluster AKS"
}

variable "namespace" {
  type = string
  default = ""
  description = ""
}

variable "state_rgname" {
  type = string
  default = ""
  description = ""
}

variable "storeacount" {
  type = string
  default = ""
  description = ""
}