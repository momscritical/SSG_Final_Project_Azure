data "azurerm_resources" "aks-nsg" {
    type = "Microsoft.Network/networkSecurityGroups"

    required_tags = {
        Type = "AKS"
    }
    depends_on = [
      azurerm_kubernetes_cluster.yeah-cluster
    ]
}


data "azurerm_network_security_group" "ngs" {
    name = data.azurerm_resources.aks-nsg.resources[0].name
    resource_group_name = data.azurerm_resources.aks-nsg.resources[0].resource_group_name
}