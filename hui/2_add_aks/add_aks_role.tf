# namespace는 dev, service account 이름은 storage-sa
resource "azurerm_federated_identity_credential" "kube-fic" {
    name                = "${var.az_prefix}-for-kubernetes"
    resource_group_name = data.azurerm_resource_group.rg.name
    audience            = ["api://AzureADTokenExchange"]
    issuer              = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
    parent_id           = data.azurerm_user_assigned_identity.uai.id
    subject             = "system:serviceaccount:dev:storage-sa"
    #subject             = "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:${SERVICE_ACCOUNT_NAME}"
    depends_on = [
        azurerm_kubernetes_cluster.aks_cluster
    ]
}
