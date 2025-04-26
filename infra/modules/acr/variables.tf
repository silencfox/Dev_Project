
 variable "rgname" {}

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
  default     = "acrdevsu"
  description = "container registry name"
 }

variable "create_acr" {
  type    = bool
  default = true
}
