variable "rgname" {
  type        = string
  description = "resource group name"

}

variable "location" {
  type    = string
  default = "brazilsouth"
}

variable "service_principal_name" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "SUB_ID" {
  type = string
}


variable "aks_name" {
  type = string
}

variable "sku" {
  type = string
}
variable "acr_name" {
  type = string
}

variable "create_acr" {
  type    = bool
  default = true
}

variable "ghpathfile" {
  type = string
}

variable "TF_VAR_ghtoken" {
  type = string
}

variable "environment" {
  type = string
  description = "Ambiente de la infra Dev, QA, Prod"
}
