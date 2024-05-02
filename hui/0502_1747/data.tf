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
    name                 = "${var.azure_basic.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "web_subnet" {
    name                 = "${var.azure_web.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "was_subnet" {
    name                 = "${var.azure_was.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "app_gw_subnet" {
    name                 = "${var.azure_application_gateway.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
}
##################################################################
data "azurerm_application_security_group" "basic_asg" {
    name                = "${var.azure_basic.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_application_security_group" "web_asg" {
    name                = "${var.azure_web.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_application_security_group" "was_asg" {
    name                = "${var.azure_was.prefix}_asg"
    resource_group_name = data.azurerm_resource_group.rg.name
}
##################################################################
data "azurerm_network_security_group" "nsg" {
    name                = "aks_nsg"
    resource_group_name = data.azurerm_resource_group.rg.name
}