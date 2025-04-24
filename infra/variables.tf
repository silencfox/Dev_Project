
variable "tenant_id" {}
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}



variable "rgname" {
  type        = string
  description = "resource group name"

}

variable "location" {
  type    = string
  default = "canadacentral"
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


variable "SUB_ID" {
  type = string
}
variable "sku" {
  type = string
}
variable "acr_name" {
  type = string
}
variable "ghpathfile" {
  type = string
}
variable "TF_VAR_ghtoken" {
  type = string
}
