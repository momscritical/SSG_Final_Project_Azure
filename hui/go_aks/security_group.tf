resource "azurerm_application_security_group" "web-app-sg" {
  name                = "web-app-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Name = "web-app-sg"
  }
}

resource "azurerm_application_security_group" "was-app-sg" {
  name                = "was-app-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Name = "was-app-sg"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "nsg-web"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-80-web"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"

    source_address_prefix      = "*"
    source_port_range          = "*"

    destination_port_range     = "80"
    destination_application_security_group_ids = [
        azurerm_application_security_group.web-app-sg.id
    ]
    
  }

}