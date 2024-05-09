data "azurerm_resource_group" "rg" {
    name = "${var.az_prefix}_rg"
}

data "azurerm_virtual_network" "vnet" {
    name = "${var.az_prefix}_vnet"
    resource_group_name = "${var.az_prefix}_rg"
}