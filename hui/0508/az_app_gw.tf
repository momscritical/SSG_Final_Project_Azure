# resource "azurerm_public_ip" "app_gw_1_pip" {
#     name                = "${var.az_prefix}_${var.az_app_gw_1.prefix}_pip"
#     resource_group_name = data.azurerm_resource_group.rg.name
#     location            = data.azurerm_resource_group.rg.location
#     allocation_method   = "Dynamic"
# }
# ##################################################################
# resource "azurerm_application_gateway" "app_gw_1" {
#     name                = "${var.az_prefix}_${var.az_app_gw_1.prefix}"
#     resource_group_name = data.azurerm_resource_group.rg.name
#     location            = data.azurerm_resource_group.rg.location
#     sku {
#         name     = var.az_app_gw_1.name
#         tier     = var.az_app_gw_1.tier
#         capacity = var.az_app_gw_1.capacity
#     }

#     gateway_ip_configuration {
#         name      = "${var.az_app_gw_1.prefix}_ip_config"
#         subnet_id = data.azurerm_subnet.app_gw_subnet.id
#     }

#     frontend_port {
#         name = "${var.az_app_gw_1.prefix}_frontend_port"
#         port = var.azure_app_gw.frontend_port
#     }

#     frontend_ip_configuration {
#         name                 = "${var.az_app_gw_1.prefix}_frontend_ip_config"
#         public_ip_address_id = azurerm_public_ip.app_gw_1_pip.id
#         private_ip_address = var.azure_app_gw.private_ip_address
#         private_ip_address_allocation = var.azure_app_gw.private_ip_address_allocation
#     }

#     backend_address_pool {
#         name = "${var.az_prefix}_backend_address_pool"
#     }

#     backend_http_settings {
#         name                  = "${var.az_prefix}_backend_http_setting"
#         cookie_based_affinity = var.azure_app_gw.backend_http_settings_cookie_based_affinity
#         path                  = "/"
#         port                  = var.azure_app_gw.backend_http_settings_port
#         protocol              = var.azure_app_gw.backend_http_settings_protocol
#         request_timeout       = 60
#     }

#     http_listener {
#         name                           = "${var.az_app_gw_1.prefix}_http_listener"
#         frontend_ip_configuration_name = "${var.az_app_gw_1.prefix}_frontend_ip_configuration"
#         frontend_port_name             = "${var.az_app_gw_1.prefix}_frontend_port"
#         protocol                       = var.az_app_gw_1.backend_http_settings_protocol
#         ssl_certificate_id = azurerm_key_vault.key_vault.id
#     }

#     request_routing_rule {
#         name                       = "${var.az_app_gw_1.prefix}_request_routing_rule"
#         priority                   = var.az_app_gw_1.request_routing_rule_priority
#         rule_type                  = var.az_app_gw_1.request_routing_rule_type
#         http_listener_name         = "${var.az_app_gw_1.prefix}_http_listener"
#         backend_address_pool_name  = "${var.az_prefix}_backend_address_pool"
#         backend_http_settings_name = "${var.az_prefix}_backend_http_setting"
#     }
# }