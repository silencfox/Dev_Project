
 variable "resource_group_name" {}

variable "TF_VAR_ghtoken" {
  type        = string
  default     = "#{TF_VAR_ghtoken}#"
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
  default     = "nodejsacr"
  description = "container registry name"
 }
