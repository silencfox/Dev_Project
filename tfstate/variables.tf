variable "tenant_id" {}
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "location" {
  type    = string
  default = "canadacentral"
}

variable "rgname" {
  type        = string
  description = "resource group name"

}

variable "storeacount" {
  type        = string
  description = "resource group name"

}
