resource "azurerm_network_security_rule" "ssh_http_https_allow" {
    name                        = "ssh_http_https_allow"
    priority                    = 150
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    
    source_port_range           = "*"
    destination_port_ranges      = ["22", "80", "443"]
    
    source_address_prefix = "*"
    destination_application_security_group_ids = [ data.azurerm_application_security_group.svc_asg.id ]
    
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = data.azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "deny_all" {
    name                        = "deny left"
    priority                    = 300
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "Tcp"
    
    source_port_range           = "*"
    destination_port_range      = "*"
    
    source_address_prefix = "*"
    destination_application_security_group_ids = [ data.azurerm_application_security_group.svc_asg.id ]
    
    resource_group_name         = data.azurerm_resource_group.rg.name
    network_security_group_name = data.azurerm_network_security_group.nsg.name
}