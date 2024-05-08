data "azurerm_resource_group" "rg" {
  name = "${var.az_prefix}_rg"
}
data "azurerm_virtual_network" "vnet" {
  name                = "${var.az_prefix}_vnet"
  resource_group_name = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "basic_subnet" {
  name                 = "${var.az_prefix}_basic_subnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "svc_subnet" {
  name                 = "${var.az_prefix}_svc_subnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "GatewaySubnet" {
  name                 = "Gatewaysubnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_application_security_group" "basic_asg" {
  name                = "basic_asg"
  resource_group_name = "${var.az_prefix}_rg"
}
data "azurerm_application_security_group" "svc_asg" {
  name                = "svc_asg"
  resource_group_name = "${var.az_prefix}_rg"
}
