resource "azurerm_virtual_network_gateway" "VNet1GW" {
    name                = "${var.az_prefix}_VNet1GW"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name

    type     = var.vnet_gw.type
    vpn_type = var.vnet_gw.vpn_type
    sku      = var.vnet_gw.sku
    generation = var.vnet_gw.generation

    active_active = true
    enable_bgp    = true
    
    bgp_settings {
        asn = var.azure_asn # azure값과 aws값이 달라야 함
        peering_addresses {
            ip_configuration_name = var.azure_peering_1.ip_configuration_name
            apipa_addresses = var.azure_peering_1.apipa_bgp_addresses
        }
        peering_addresses {
	        ip_configuration_name = var.azure_peering_2.ip_configuration_name
            apipa_addresses = var.azure_peering_2.apipa_bgp_addresses
        }
    }
    ip_configuration {
        name = var.azure_peering_1.ip_configuration_name
        subnet_id = azurerm_subnet.GatewaySubnet.id
        public_ip_address_id = azurerm_public_ip.gwpip1.id
    }
    ip_configuration {
        name = var.azure_peering_2.ip_configuration_name
        subnet_id = azurerm_subnet.GatewaySubnet.id
        public_ip_address_id = azurerm_public_ip.gwpip2.id
    }  
    lifecycle {
        create_before_destroy = true
    }
}
#===============================================================================
resource "azurerm_local_network_gateway" "AWSTunnel1ToInstance1" {
    name                = "AWSTunnel1ToInstance1"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    gateway_address     = aws_vpn_connection.ToAzureInstance1.tunnel1_address
    bgp_settings {
        asn = var.aws_asn # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = var.azure_peering_1.bgp_addresses[0]
    }  
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_local_network_gateway" "AWSTunnel2ToInstance1" {
    name                = "AWSTunnel2ToInstance1"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    gateway_address     = aws_vpn_connection.ToAzureInstance1.tunnel2_address
    bgp_settings {
        asn = var.aws_asn # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = var.azure_peering_1.bgp_addresses[1]
    }
    
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_local_network_gateway" "AWSTunnel1ToInstance2" {
    name                = "AWSTunnel1ToInstance2"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    gateway_address     = aws_vpn_connection.ToAzureInstance2.tunnel1_address
    bgp_settings {
        asn = var.aws_asn # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = var.azure_peering_2.bgp_addresses[0]
    }
    
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_local_network_gateway" "AWSTunnel2ToInstance2" {
    name                = "AWSTunnel2ToInstance2"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location
    gateway_address     = aws_vpn_connection.ToAzureInstance2.tunnel2_address
    bgp_settings {
        asn = var.aws_asn # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = var.azure_peering_2.bgp_addresses[1]
    }
    lifecycle {
        create_before_destroy = true
    }
}