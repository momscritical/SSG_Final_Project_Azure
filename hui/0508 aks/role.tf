
resource "azurerm_user_assigned_identity" "base" {
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    name                = "${var.az_prefix}_uai"
    lifecycle {
      create_before_destroy = true
    }
}

# namespace는 dev, service account 이름은 blob-sa
resource "azurerm_federated_identity_credential" "kube-fic" {
    name                = "kubernetes-federated-identity"
    resource_group_name = data.azurerm_resource_group.rg.name
    audience            = ["api://AzureADTokenExchange"]
    issuer              = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
    parent_id           = data.azurerm_user_assigned_identity.base.id
    subject             = "system:serviceaccount:dev:blob-sa"
    #subject             = "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:${SERVICE_ACCOUNT_NAME}"
    depends_on = [
        azurerm_kubernetes_cluster.aks_cluster
    ]
}
