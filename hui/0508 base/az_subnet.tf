resource "azurerm_subnet" "GatewaySubnet" {
    name                 = var.az_gw_subnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.az_gw_subnet.address_prefix]
    lifecycle {
        create_before_destroy = true
    }
}
# delegation - "이 subnet은 오로지 이걸 위해서만 사용할 거에용"
# service endpoint - 안전한 연결!
resource "azurerm_subnet" "db_subnet" {
    name                 = "${var.az_prefix}_${var.az_db.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.az_db.sub_ip_address]
    service_endpoints = var.az_db.sub_service_endpoints
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


