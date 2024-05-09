data "azurerm_resource_group" "rg" {
  name = "${var.az_prefix}_rg"
}
data "azurerm_virtual_network" "vnet" {
  name                = "${var.az_prefix}_vnet"
  resource_group_name = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "GatewaySubnet" {
  name                 = "Gatewaysubnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "db_subnet" {
  name                 = "${var.az_prefix}_${var.az_db.prefix}_subnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "ingr_app_subnet" {
  name                 = "${var.az_prefix}_${var.az_ingr_app.prefix}_subnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "basic_subnet" {
  name                 = "${var.az_prefix}_${var.az_basic.prefix}_subnet"
  virtual_network_name = "${var.az_prefix}_vnet"
  resource_group_name  = "${var.az_prefix}_rg"
}
data "azurerm_subnet" "svc_subnet" {
  name                 = "${var.az_prefix}_${var.az_svc.prefix}_subnet"
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

data "azurerm_network_security_group" "nsg" {
  name                = "${var.az_prefix}_nsg"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_client_config" "client_config" {
}
