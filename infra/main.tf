resource "azurerm_resource_group" "rg1" {
  name     = "${var.aks_rgname}-${var.environment}"
  location = var.location
}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name               
  resource_group_name = var.acr_rgname                
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "acr" {
  backend = "azurerm"  # o el backend que estés usando
  config = {
    resource_group_name  = "rg-devsu-tfstate"
    storage_account_name = "tfdevsublobstorage007011"
    container_name       = "tfstate"
    key                  = "terraform_acr.tfstate"  # archivo del state remoto
  }
}

data "azurerm_container_registry" "acr_remote" {
  name                = data.terraform_remote_state.acr.outputs.container_registry_name
  resource_group_name = data.terraform_remote_state.acr.outputs.container_registry_resource_group
}

module "ServicePrincipal" {
  source                 = "./modules/ServicePrincipal"
  service_principal_name = var.service_principal_name

  depends_on = [
    azurerm_resource_group.rg1
  ]
}

module "aks" {
  source                 = "./modules/aks/"
  service_principal_name = var.service_principal_name
  client_id              = module.ServicePrincipal.client_id
  client_secret          = module.ServicePrincipal.client_secret
  cluster_name           = "${var.cluster_name}-${var.environment}"
  location               = var.location
  resource_group_name    = "${var.aks_rgname}-${var.environment}"
  environment            = var.environment
  
  depends_on = [
    module.ServicePrincipal
  ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.kube_config
  
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  #principal_id         = module.aks.aks_principal_id
  principal_id         = module.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr_remote.id

  depends_on = [
    module.aks
  ]

}

resource "azurerm_role_assignment" "acr_Push" {
  scope                = data.azurerm_container_registry.acr_remote.id
  role_definition_name = "AcrPush"
  principal_id         = data.azurerm_client_config.current.object_id
}