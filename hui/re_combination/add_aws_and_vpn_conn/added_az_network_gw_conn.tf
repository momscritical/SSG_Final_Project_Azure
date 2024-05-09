# 연결 만들기

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel1toAzureInstance1" {
    name                = "AWSTunnel1toAzureInstance1"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    type                       = var.vnet_ngw_conn_type # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel1ToInstance1.id
    shared_key = var.preshared_key[0]
    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    }
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_virtual_network_gateway_connection" "AWSTunnel2toAzureInstance1" {
    name                = "AWSTunnel2toAzureInstance1"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    type                       = var.vnet_ngw_conn_type # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel2ToInstance1.id
    shared_key = var.preshared_key[1]
    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[1]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    }  
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel1toAzureInstance2" {
    name                = "AWSTunnel1toAzureInstance2"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    type                       = var.vnet_ngw_conn_type # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel1ToInstance2.id
    shared_key = var.preshared_key[0]
    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    } 
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel2toAzureInstance2" {
    name                = "AWSTunnel2toAzureInstance2"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    type                       = var.vnet_ngw_conn_type # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel2ToInstance2.id
    shared_key = var.preshared_key[1]
    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[1]
    }   
    lifecycle {
        create_before_destroy = true
    }
}
