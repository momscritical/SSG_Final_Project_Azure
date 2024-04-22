
resource "azurerm_resource_group" "TestRG1" {
    name = "TestRG1"
    location = "Korea Central"

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network" "VNet1" {
    name                = "VNet1"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name
    address_space       = ["10.1.0.0/16"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_subnet" "FrontEnd" {
    name                 = "FrontEnd"
    resource_group_name  = azurerm_resource_group.TestRG1.name
    virtual_network_name = azurerm_virtual_network.VNet1.name
    address_prefixes     = ["10.1.0.0/24"]
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.TestRG1.name
    virtual_network_name = azurerm_virtual_network.VNet1.name
    address_prefixes     = ["10.1.1.0/24"]
    
    lifecycle {
        create_before_destroy = true
    }
}


resource "azurerm_public_ip" "VNet1GWPip" {
    name                = "VNet1GWPip"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    allocation_method = "Static"
    sku = "Standard"
    zones = ["1","2","3"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_public_ip" "VNet1GWPip2" {
    name                = "VNet1GWPip2"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    allocation_method = "Static"
    sku = "Standard"
    zones = ["1","2","3"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network_gateway" "VNet1GW" {
    name                = "VNet1GW"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    type     = "Vpn"
    vpn_type = "RouteBased"
    sku      = "VpnGw2AZ"
    generation = "Generation2"

    active_active = true
    enable_bgp    = true
    
    bgp_settings {
        asn = 65000 # azure값과 aws값이 달라야 함
        peering_addresses {
            ip_configuration_name = "VNet1GWConfig"
            apipa_addresses = ["169.254.21.2", "169.254.22.2"]
        }
        peering_addresses {
	        ip_configuration_name = "VNet1GWConfig2"
            apipa_addresses = ["169.254.21.6", "169.254.22.6"]
        }
    }
 
    ip_configuration {
        name = "VNet1GWConfig"
        subnet_id = azurerm_subnet.GatewaySubnet.id
        public_ip_address_id = azurerm_public_ip.VNet1GWPip.id
    }
    ip_configuration {
        name = "VNet1GWConfig2"
        subnet_id = azurerm_subnet.GatewaySubnet.id
        public_ip_address_id = azurerm_public_ip.VNet1GWPip2.id
    }

    
    lifecycle {
        create_before_destroy = true
    }
}


# 3부 Azure -> AWS
# 로컬 게이트웨이 만들기

resource "azurerm_local_network_gateway" "AWSTunnel1ToInstance0" {
    name                = "AWSTunnel1ToInstance0"
    resource_group_name = azurerm_resource_group.TestRG1.name
    location            = azurerm_resource_group.TestRG1.location

    gateway_address     = aws_vpn_connection.ToAzureInstance0.tunnel1_address

    bgp_settings {
        asn = "64512" # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = "169.254.21.1"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_local_network_gateway" "AWSTunnel2ToInstance0" {
    name                = "AWSTunnel2ToInstance0"
    resource_group_name = azurerm_resource_group.TestRG1.name
    location            = azurerm_resource_group.TestRG1.location

    gateway_address     = aws_vpn_connection.ToAzureInstance0.tunnel2_address

    bgp_settings {
        asn = "64512" # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = "169.254.22.1"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_local_network_gateway" "AWSTunnel1ToInstance1" {
    name                = "AWSTunnel1ToInstance1"
    resource_group_name = azurerm_resource_group.TestRG1.name
    location            = azurerm_resource_group.TestRG1.location

    gateway_address     = aws_vpn_connection.ToAzureInstance1.tunnel1_address

    bgp_settings {
        asn = "64512" # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = "169.254.21.5"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_local_network_gateway" "AWSTunnel2ToInstance1" {
    name                = "AWSTunnel2ToInstance1"
    resource_group_name = azurerm_resource_group.TestRG1.name
    location            = azurerm_resource_group.TestRG1.location

    gateway_address     = aws_vpn_connection.ToAzureInstance1.tunnel2_address

    bgp_settings {
        asn = "64512" # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = "169.254.22.5"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

# 연결 만들기

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel1toAzureInstance0" {
    name                = "AWSTunnel1toAzureInstance0"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    type                       = "IPsec" # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel1ToInstance0.id

    shared_key = "always_sleepy_0418"

    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel2toAzureInstance0" {
    name                = "AWSTunnel2toAzureInstance0"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    type                       = "IPsec" # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel2ToInstance0.id

    shared_key = "always_sleepy_0418"

    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[1]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_virtual_network_gateway_connection" "AWSTunnel1toAzureInstance1" {
    name                = "AWSTunnel1toAzureInstance1"
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    type                       = "IPsec" # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel1ToInstance1.id

    shared_key = "always_sleepy_0418"

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
    location            = azurerm_resource_group.TestRG1.location
    resource_group_name = azurerm_resource_group.TestRG1.name

    type                       = "IPsec" # means 'site-to-site'
    virtual_network_gateway_id = azurerm_virtual_network_gateway.VNet1GW.id
    local_network_gateway_id   = azurerm_local_network_gateway.AWSTunnel2ToInstance1.id

    shared_key = "always_sleepy_0418"

    enable_bgp = true
    custom_bgp_addresses {
        primary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
        secondary = azurerm_virtual_network_gateway.VNet1GW.bgp_settings[0].peering_addresses[1].apipa_addresses[1]
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

