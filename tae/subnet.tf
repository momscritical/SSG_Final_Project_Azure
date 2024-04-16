# Bastion Subnet
resource "azurerm_subnet" "public" {
    name = "Bastion-Subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name

    count      = length(var.public_subnets)
    address_prefixes = element(var.public_subnets, count.index)
}

# Web Subnet
resource "azurerm_subnet" "web" {
    name = "Web-Subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name

    address_prefixes = ["10.0.0.0/24"]
}

# WAS Subnet
resource "azurerm_subnet" "was" {
    name = "WAS-Subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name

    address_prefixes = ["10.0.1.0/24"]
}

# DataBaste Subnet
resource "azurerm_subnet" "db" {
    name = "DB-Subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name

    address_prefixes = ["10.0.1.0/24"]
}