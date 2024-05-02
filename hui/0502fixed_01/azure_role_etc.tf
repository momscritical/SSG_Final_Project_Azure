
resource "azurerm_user_assigned_identity" "base" {
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    name                = var.azure_name_prefix
    lifecycle {
      create_before_destroy = true
    }
}

data "azurerm_client_config" "client_config" {
}

resource "azurerm_role_assignment" "base" {
    scope              = azurerm_virtual_network.vnet.id
    role_definition_name = var.network_role_name
    principal_id       = data.azurerm_client_config.client_config.object_id
    lifecycle {
      create_before_destroy = true
    }
}


resource "azurerm_federated_identity_credential" "kube-fic" {
  name                = "kubernetes-federated-identity"
  resource_group_name = azurerm_resource_group.rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.base.id
  subject             = "system:serviceaccount:dev:blob-sa"
  #subject             = "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:${SERVICE_ACCOUNT_NAME}"
}

# NAMESPACE="dev"
# SERVICE_ACCOUNT_NAME="blob-sa"