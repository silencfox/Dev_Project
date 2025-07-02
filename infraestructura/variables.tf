variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "client_secret" {}


variable "rgname" {
  type        = string
  description = "resource group name"

}

variable "location" {
  type    = string
  default = "brazilsouth"
  description = "Location of the resource group."
}

variable "aks_name" {
  type = string
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


variable "cluster_name" {
  type = string
  default = "Devsu-aks-cluster"
  description = "Nombre del cluster AKS"
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

variable "min_count" {
  description = "min auto_scaling"
}
variable "max_count" {
  description = "max auto_scaling"
}
variable "os_disk_size_gb" {
  description = "disk size"
}
variable "vm_size" {
  description = "disk size"
}




