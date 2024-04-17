resource "azurerm_application_security_group" "bastion" {
  name                = "Final-Bastion-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "web" {
  name                = "${var.project_name_prefix}-Web-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "was" {
  name                = "${var.project_name_prefix}-WAS-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "db" {
  name                = "${var.project_name_prefix}-DS-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "ext_lb" {
  name                = "${var.project_name_prefix}-ELB-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "int_lb" {
  name                = "${var.project_name_prefix}-ILB-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "web_efs" {
  name                = "${var.project_name_prefix}-Web-EFS-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "was_efs" {
  name                = "${var.project_name_prefix}-WAS-EFS-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "cluster" {
  name                = "${var.project_name_prefix}-Cluster-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_application_security_group" "control_plane" {
  name                = "${var.project_name_prefix}-Control-Plane-ASG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}