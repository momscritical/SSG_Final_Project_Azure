output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "azure_oidc_url" {
  value = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}