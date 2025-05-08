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
