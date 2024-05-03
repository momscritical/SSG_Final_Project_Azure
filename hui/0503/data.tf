##################################################################
data "azurerm_resource_group" "rg" {
    name = "${var.azure_name_prefix}_rg"
}

data "azurerm_virtual_network" "vnet" {
    name                = "${var.azure_name_prefix}_vnet"
    resource_group_name = data.azurerm_resource_group.rg.name
}
##################################################################
data "azurerm_subnet" "basic_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_basic.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "web_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_web.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "was_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_was.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "app_gw_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_app_gw.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "db_private_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_db_private_subnet.name}"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "storage_private_subnet" {
    name                 = "${var.azure_name_prefix}_${var.azure_storage_private_subnet.name}"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}

##################################################################
data "azurerm_application_security_group" "basic_asg" {
    name                = "${var.azure_name_prefix}_${var.azure_basic.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_application_security_group" "web_asg" {
    name                = "${var.azure_name_prefix}_${var.azure_web.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_application_security_group" "was_asg" {
    name                = "${var.azure_name_prefix}_${var.azure_was.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_application_security_group" "str_priv_asg" {
    name                = "${var.azure_name_prefix}_storage_private_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
##################################################################
data "azurerm_network_security_group" "nsg" {
    name                = "${var.azure_name_prefix}_aks_nsg"
    resource_group_name = data.azurerm_resource_group.rg.name
}