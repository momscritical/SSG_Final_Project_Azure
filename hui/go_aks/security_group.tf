# asg
resource "azurerm_application_security_group" "default-pool-asg" {
    name                = "default-pool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_application_security_group" "user-pool-asg" {
    name                = "user-pool-asg"
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

    security_rule {
      name                       = "test123"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    tags = {
      environment = "TestTest"
    }
    lifecycle {
      create_before_destroy = true
    }
}