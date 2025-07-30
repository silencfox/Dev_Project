resource "azurerm_user_assigned_identity" "dev_test" {
  name                = "dev-test"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_federated_identity_credential" "dev_test" {
  name                = "dev-test"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  #issuer              = azurerm_kubernetes_cluster.aks-cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.dev_test.id
  subject             = "system:serviceaccount:dev:my-account"

  #depends_on = [module.aks.azurerm_kubernetes_cluster.aks-cluster]
}
