data "azurerm_client_config" "client_config" {
}

data "azurerm_resource_group" "rg" {
    name = "${var.az_prefix}_rg"
}

data "azurerm_virtual_network" "vnet" {
    name = "${var.az_prefix}_vnet"
    resource_group_name = "${var.az_prefix}_rg"
}
data "azurerm_kubernetes_cluster" "aks_cluster" {
    name = "${var.az_prefix}_cluster"
    resource_group_name = data.azurerm_resource_group.rg.name
}
