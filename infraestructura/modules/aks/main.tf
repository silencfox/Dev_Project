data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false  
}
 
resource "tls_private_key" "aks" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

<<<<<<< HEAD
resource "azurerm_user_assigned_identity" "base" {
  name                = "base"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "base" {
  scope                = var.resource_group_id
=======

resource "azurerm_role_assignment" "base" {
  scope                = azurerm_resource_group.this.id
>>>>>>> a45e0a35053071caaf9b3d3a041d4da1b3b39467
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}


resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                  = "${var.cluster_name}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  dns_prefix            = "${var.resource_group_name}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  private_cluster_enabled   = false
  node_resource_group = "${var.resource_group_name}-nrg"


  # For production change to "Standard" 
  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  
<<<<<<< HEAD
  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }


=======
  sku_tier = "Standard"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
>>>>>>> a45e0a35053071caaf9b3d3a041d4da1b3b39467

  default_node_pool {
    name       = "defaultpool"
    vm_size    = "Standard_DS2_v2"
    zones   = [1, 2, 3]
    auto_scaling_enabled = true
    node_count           = 1
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "${var.environment}"
      "nodepoolos"       = "linux"
     } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "${var.environment}"
      "nodepoolos"       = "linux"
   } 
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }


  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }
 #to do: generate the ssh keys using tls_private_key
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
        #key_data = trimspace(file(var.ssh_public_key))
        key_data = tls_private_key.aks.public_key_openssh
    }
  }

<<<<<<< HEAD
=======
  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }


>>>>>>> a45e0a35053071caaf9b3d3a041d4da1b3b39467
  depends_on = [
    azurerm_role_assignment.base
  ]
    
}

#################################


resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-cluster.id
  vm_size               = "Standard_DS2_v2"
  #vnet_subnet_id        = azurerm_subnet.subnet1.id
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  priority              = "Spot"
  spot_max_price        = -1
  eviction_policy       = "Delete"

  auto_scaling_enabled = true
  node_count          = 1
  min_count           = 1
  max_count           = 10

  node_labels = {
    role                                    = "spot"
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }

  node_taints = [
    "spot:NoSchedule",
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]

  tags = {
    env = "local.env"
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
