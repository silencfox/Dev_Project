
resource "azurerm_container_registry" "acr" {
  public_network_access_enabled = true
  name                = var.acr_name
  resource_group_name = var.rgname
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
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
    image_names          = ["devsudemo:latest"]
  }

  source_trigger {
    name                 = "autobuild"
    events               = ["commit"]
    enabled              = true

    source_repository {
      source_type        = "Github"
      repository_url     = "https://github.com/silencfox/Dev_Project.git"
      branch             = "main"

      source_control_auth_properties {
        token            = var.TF_VAR_ghtoken
        token_type       = "PAT"
      }
    }
  }
}

