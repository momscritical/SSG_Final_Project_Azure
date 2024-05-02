# asg
resource "azurerm_application_security_group" "basic_asg" {
    name                = "${var.azure_basic.prefix}_asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_application_security_group" "web_asg" {
    name                = "${var.azure_web.prefix}_asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_application_security_group" "was_asg" {
    name                = "${var.azure_was.prefix}_asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

# nsg
resource "azurerm_network_security_group" "nsg" {
    name                = "aks_nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
        create_before_destroy = true
    }
}

# resource "azurerm_network_security_rule" "inbound01" {
#   name                        = "inbound01"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.yeah-nsg.name
# }

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