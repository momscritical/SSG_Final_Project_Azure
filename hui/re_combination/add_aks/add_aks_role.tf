# resource "azurerm_role_assignment" "network_role_to_vnet" {
#     scope              = azurerm_kubernetes_cluster.aks_cluster.id
#     role_definition_name = var.network_role_name
#     principal_id       = data.azurerm_client_config.client_config.object_id
# }
# resource "azurerm_role_assignment" "storage_role_to_vnet" {
#     scope                = azurerm_kubernetes_cluster.aks_cluster.id
#     role_definition_name = var.storage_account_role_name
#     principal_id         = data.azurerm_client_config.client_config.object_id
# }

# Assign the Contributor role to the user-assigned identity
resource "azurerm_role_assignment" "contributor" {
    scope                = data.azurerm_resource_group.rg.id
    role_definition_name = "Contributor"
    principal_id         = azurerm_user_assigned_identity.uai.principal_id
}

resource "azurerm_user_assigned_identity" "uai" {
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    name                = "${var.az_prefix}_uai"
    lifecycle {
      create_before_destroy = true
    }
}
# namespace는 dev, service account 이름은 blob-sa
resource "azurerm_federated_identity_credential" "kube-fic" {
    name                = "for-kubernetes"
    resource_group_name = data.azurerm_resource_group.rg.name
    audience            = ["api://AzureADTokenExchange"]
    issuer              = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
    parent_id           = azurerm_user_assigned_identity.uai.id
    subject             = "system:serviceaccount:dev:blob-sa"
    #subject             = "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:${SERVICE_ACCOUNT_NAME}"
    depends_on = [
        azurerm_kubernetes_cluster.aks_cluster
    ]
}
