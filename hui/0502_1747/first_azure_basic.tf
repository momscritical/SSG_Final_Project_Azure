resource "azurerm_resource_group" "rg" {
    location = var.azure_loc
    name     = "${var.azure_name_prefix}_rg"
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.azure_name_prefix}_vnet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = [var.azure_vnet_ip_block]
    lifecycle {
      create_before_destroy = true
    }
}
##################################################################

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

resource "azurerm_subnet" "app_gw_subnet" {
    name                 = "${var.azure_app_gw.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_app_gw.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "db_private_subnet" {
    name                 = var.azure_db_private_subnet.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_db_private_subnet.address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}

# service_delegation
# name = "Microsoft.DBforMySQL/flexibleServers"

