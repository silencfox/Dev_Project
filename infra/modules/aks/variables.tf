variable "location" {

}
 variable "resource_group_name" {}

variable "cluster_name" {
  type = string
  default = "Devsu-aks-cluster"
  description = "Nombre del cluster AKS"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}


variable "environment" {
  type = string
  description = "Ambiente de la infra Dev, QA, Prod"
}