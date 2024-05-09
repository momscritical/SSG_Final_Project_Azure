output "cluster_issuer_url" {
    value = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
    sensitive = true
}
# The fully qualified domain name (FQDN) of the AKS cluster portal.
output "portal_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.portal_fqdn
}
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
# The client certificate for accessing the AKS cluster.
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
  sensitive = true
}


output "config_subscription_id" {
    value = data.azurerm_client_config.client_config.subscription_id
    sensitive = true
}
output "config_client_id" {
    value = data.azurerm_client_config.client_config.client_id
    sensitive = true
}
output "config_tenant_id" {
    value = data.azurerm_client_config.client_config.tenant_id
    sensitive = true
}
output "config_object_id" {
    value = data.azurerm_client_config.client_config.object_id
    sensitive = true
}

output "federated_id" {
    value = azurerm_federated_identity_credential.kube-fic.id
}