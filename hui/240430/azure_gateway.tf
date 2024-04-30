resource "azurerm_virtual_network_gateway" "VNet1GW" {
    name                = "${var.azure_name_prefix}_VNet1GW"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

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
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
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
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
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
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
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
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    gateway_address     = aws_vpn_connection.ToAzureInstance2.tunnel2_address
    bgp_settings {
        asn = var.aws_asn # AWS에서 설정한 ASN. AWS 기본값 64512
        bgp_peering_address = var.azure_peering_2.bgp_addresses[1]
    }
    lifecycle {
        create_before_destroy = true
    }
}












# # agw
# resource "azurerm_application_gateway" "agw-1" {
#   name                = "${var.agw_name_1}"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location

#   sku {
#     name     = "${var.agw_sku.name}"
#     tier     = "${var.agw_sku.tier}"
#     capacity = "${var.agw_sku.capacity}"
#   }

#   gateway_ip_configuration {
#     name      = "${var.agw_name_1}-ip-config"
#     subnet_id = azurerm_subnet.application-gateway-subnet01.id
#   }

#   frontend_port {
#     name = "${var.agw_name_1}-frontend-port"
#     port = 80
#   }

#   frontend_ip_configuration {
#     name                 = "${var.agw_name_1}-frondend-ip"
#     public_ip_address_id = azurerm_public_ip.public-ip-1.id
#   }

#   backend_address_pool {
#     name = "${var.agw_name_1}-backend-pool"
#     ip_addresses = [
      
#     ]
#   }

#   backend_http_settings {
#     name                  = "${var.agw_name_1}-http-setting"
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 60
#   }

#   http_listener {
#     name                           = "${var.agw_name_1}-listener"
#     frontend_ip_configuration_name = "${var.agw_name_1}-frontend-ip"
#     frontend_port_name             = "${var.agw_name_1}-frontend-port"
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = "${var.agw_name_1}-routingrule"
#     rule_type                  = "Basic"
#     http_listener_name         = "${var.agw_name_1}-listener"
#     backend_address_pool_name  = "${var.agw_name_1}-backend-pool"
#     backend_http_settings_name = "${var.agw_name_1}-http-setting"
#     priority                   = 3
#   }
# }