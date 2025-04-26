
resource "azurerm_container_registry" "acr" {
  public_network_access_enabled = true
  name                = var.acr_name
  resource_group_name = var.rgname
  location            = var.location
  sku                 = var.sku
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = "acr_task"
  enabled               = var.create_acr
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.ghpathfile
    context_access_token = var.TF_VAR_ghtoken
    image_names          = ["devsudemo:{{.Run.ID}}"]
  }
}

