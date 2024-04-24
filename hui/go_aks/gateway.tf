
# agw
resource "azurerm_application_gateway" "main" {
  name                = "myAppGateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.agw-subnet-1.id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ipconfig"
    public_ip_address_id = azurerm_public_ip.public-ip-for-agw.id
  }

  backend_address_pool {
    name = "backendpool"
  }

  backend_http_settings {
    name                  = "httpSetting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "yeah-listener"
    frontend_ip_configuration_name = "frontend-ipconfig"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "yeah-routingrule"
    rule_type                  = "Basic"
    http_listener_name         = "yeah-listener"
    backend_address_pool_name  = "backendpool"
    backend_http_settings_name = "httpSetting"
    priority                   = 3
  }
}