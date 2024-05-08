resource "azurerm_network_security_group" "nsg" {
    name                = "${var.az_prefix}_nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
        create_before_destroy = true
    }
}

# resource "azurerm_network_security_rule" "ssh_allow" {
#   name                        = "ssh_allow"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }
