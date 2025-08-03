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

module "vpc" {
  source                 = "./modules/vpc"
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg1.name
  depends_on = [ azurerm_resource_group.rg1 ]  
}

module "acr" {
  source                 = "./modules/acr"
  location               = var.location
  rgname                 = azurerm_resource_group.rg1.name
  sku                    = var.sku
  acr_name               = var.acr_name
  #create_acr             = var.create_acr
  ghpathfile             = var.ghpathfile
  TF_VAR_ghtoken         = var.TF_VAR_ghtoken
  depends_on = [ azurerm_resource_group.rg1 ]
}

module "aks" {
  source                 = "./modules/aks/"
  cluster_name           = "${var.cluster_name}-${var.environment}"
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg1.name
  resource_group_id      = azurerm_resource_group.rg1.id
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


module "identity" {
  source                 = "./modules/identity"
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg1.name
  oidc_issuer_url     = module.aks.oidc_issuer_url
  depends_on = [
    module.aks
  ]

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

#module "dns" {
#  source                 = "./modules/dns"

#  depends_on = [
#    module.helm
#  ]
#}