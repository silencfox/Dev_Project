variable "location" {

}
 variable "resource_group_name" {}

variable "cluster_name" {
  type = string
  default = "Devsu-aks-cluster"
  description = "Nombre del cluster AKS"
}

variable "service_principal_name" {
  type = string
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "client_id" {}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "environment" {
  type = string
  description = "Ambiente de la infra Dev, QA, Prod"
}