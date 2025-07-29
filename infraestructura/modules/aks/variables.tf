variable "location" {

}
variable "resource_group_name" {}

variable "resource_group_id" {}

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


