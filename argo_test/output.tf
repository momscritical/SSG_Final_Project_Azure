output "kube_config" {
  value     = azurerm_kubernetes_cluster.yeah-cluster.kube_config_raw
  sensitive = true
}