# Bastion Subnet
resource "azurerm_subnet" "public" {
  count               = length(var.public_subnets)
  name                = "${var.project_name_prefix}-Public-Subnet-0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name= azurerm_virtual_network.vn.name
  address_prefixes    = [ element(var.public_subnets, count.index) ]

  depends_on = [ azurerm_virtual_network.vn ]
}

# Web Subnet
resource "azurerm_subnet" "web" {
  count               = length(var.web_subnets)
  name                = "${var.project_name_prefix}-Web-Subnet-0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name= azurerm_virtual_network.vn.name
  address_prefixes    = [ element(var.web_subnets, count.index) ]

  depends_on = [ azurerm_virtual_network.vn ]
}

# WAS Subnet
resource "azurerm_subnet" "was" {
  count               = length(var.was_subnets)
  name                = "${var.project_name_prefix}-WAS-Subnet-0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name= azurerm_virtual_network.vn.name
  address_prefixes    = [ element(var.was_subnets, count.index) ]

  depends_on = [ azurerm_virtual_network.vn ]
}

# Database Subnet
resource "azurerm_subnet" "db" {
  count               = length(var.db_subnets)
  name                = "${var.project_name_prefix}-DB-Subnet-0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name= azurerm_virtual_network.vn.name
  address_prefixes    = [ element(var.db_subnets, count.index) ]

  depends_on = [ azurerm_virtual_network.vn ]
}