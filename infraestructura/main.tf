##########################
##      Create by       ##
##   Kelvin D. Alcala   ##
##      28-04-2025      ##
##########################

variable "environment" {
  type = string
  description = "Ambientes de la infra devsu-dev, devsu-qa, devsu-prod"
  default     = "DEV"
}

#locals {
#  environment = var.environment != "" ? var.environment : terraform.workspace
#}

resource "azurerm_resource_group" "rg1" {
  name     = "${var.rgname}-${var.environment}"
  location = var.location
}

data "azurerm_client_config" "current" {}

module "acr" {
  source                 = "./modules/acr"
  location               = var.location
  rgname                 = "${var.rgname}-${var.environment}"
  sku                    = var.sku
  acr_name               = var.acr_name
  #create_acr             = var.create_acr
  ghpathfile             = var.ghpathfile
  TF_VAR_ghtoken         = var.TF_VAR_ghtoken
}

module "aks" {
  source                 = "./modules/aks/"
  cluster_name           = "${var.cluster_name}-${var.environment}"
  location               = var.location
  resource_group_name    = "${var.rgname}-${var.environment}"
  environment            = var.environment
  min_count              = var.min_count
  max_count              = var.max_count
  vm_size                = var.vm_size
  os_disk_size_gb        = "var.os_disk_size_gb"

  depends_on = [
    module.acr
  ]

}

resource "local_file" "kubeconfig2" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig2"
  content      = module.aks.kube_config2
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = module.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = module.acr.acr_id

  depends_on = [
    module.aks
  ]

}

resource "azurerm_role_assignment" "acr_Push" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPush"
  principal_id         = data.azurerm_client_config.current.object_id
}

module "add-ons" {
  source                 = "./modules/add-ons"
  depends_on = [
    module.aks
  ]
}

#module "helm" {
#  source                 = "./modules/helm"

#  depends_on = [
#    module.cert-mng
#  ]

#}