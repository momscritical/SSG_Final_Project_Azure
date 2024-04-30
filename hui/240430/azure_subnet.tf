resource "azurerm_subnet" "FrontEnd" {
    name                 = "${var.azure_frontend.prefix}_subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.azure_frontend.address_prefix] 
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_subnet" "GatewaySubnet" {
    name                 = var.azure_gateway_subnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.azure_gateway_subnet.address_prefix]
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_subnet" "basic_subnet" {
    name                 = "${var.azure_basic.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_basic.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "web_subnet" {
    name                 = "${var.azure_web.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_web.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "was_subnet" {
    name                 = "${var.azure_was.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_was.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}
