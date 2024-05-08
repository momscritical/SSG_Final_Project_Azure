resource "azurerm_subnet" "basic_subnet" {
    name                 = "${var.az_prefix}_${var.az_basic.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.az_basic.sub_ip_address]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "svc_subnet" {
    name                 = "${var.az_prefix}_${var.az_svc.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.az_svc.sub_ip_address]
    service_endpoints = var.az_svc.sub_service_endpoints
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "GatewaySubnet" {
    name                 = var.az_gw_subnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.az_gw_subnet.address_prefix]
    service_endpoints    = var.az_gw_subnet.sub_service_endpoints
    delegation {
        name = "delegation to flexibleServers"
        service_delegation {
            name = "Microsoft.DBforMySQL/flexibleServers"
            actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            ]
        }
    }
    lifecycle {
        create_before_destroy = true
    }
}

# resource "azurerm_subnet" "app_gw_1_subnet" {
#     name                 = "${var.az_prefix}_${var.az_app_gw_1.prefix}_subnet"
#     virtual_network_name = azurerm_virtual_network.vnet.name
#     resource_group_name  = azurerm_resource_group.rg.name
#     address_prefixes     = [var.az_app_gw_1.sub_ip_address]
#     lifecycle {
#       create_before_destroy = true
#     }
# }

# resource "azurerm_subnet" "app_gw_2_subnet" {
#     name                 = "${var.az_prefix}_${var.az_app_gw_2.prefix}_subnet"
#     virtual_network_name = azurerm_virtual_network.vnet.name
#     resource_group_name  = azurerm_resource_group.rg.name
#     address_prefixes     = [var.az_app_gw_2.sub_ip_address]
#     lifecycle {
#       create_before_destroy = true
#     }
# }