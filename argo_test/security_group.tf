# asg
resource "azurerm_application_security_group" "basicpool-asg" {
    name                = "basicpool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_application_security_group" "webpool-asg" {
    name                = "webpool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_application_security_group" "waspool-asg" {
    name                = "waspool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}


# nsg
resource "azurerm_network_security_group" "yeah-nsg" {
    name                = "yeah-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_network_security_rule" "inbound01" {
  name                        = "inbound01"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.yeah-nsg.name
}

# resource "azurerm_network_security_rule" "outbound101" {
#   name                        = "rul1"
#   priority                    = 100
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.yeah-nsg.name
# }