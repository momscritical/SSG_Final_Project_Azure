######## added - begin ########
data "azurerm_user_assigned_identity" "uai" {
    name = "${var.az_prefix}_master_key"
    resource_group_name = "${var.az_prefix}_rg"
}
######## added - end ##########

data "azurerm_client_config" "client_config" {
}

data "azurerm_resource_group" "rg" {
    name = "${var.az_prefix}_rg"
}

data "azurerm_virtual_network" "vnet" {
    name = "${var.az_prefix}_vnet"
    resource_group_name = "${var.az_prefix}_rg"
}

