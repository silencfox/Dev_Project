
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
}
resource "azurerm_container_registry_task" "acr-task" {
  name                  = "acr-task"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.ghpathfile
    context_access_token = var.TF_VAR_ghtoken
    image_names          = ["helloworld:{{.Run.ID}}"]
  }
}

