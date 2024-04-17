# Create Network Security Group and Rule for Bastion
resource "azurerm_network_security_group" "bastion" {
  name                = "${var.project_name_prefix}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "web" {
  name                = "${var.project_name_prefix}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    source_application_security_group_ids = [ azurerm_application_security_group.bastion.id ]
    destination_port_range     = "22"
    destination_application_security_group_ids = [ azurerm_application_security_group.web.id ]
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    source_application_security_group_ids = [ azurerm_application_security_group.ext_lb.id ]
    destination_port_range     = "80"
    destination_application_security_group_ids = [ azurerm_application_security_group.web.id ]
  }
}

resource "azurerm_network_security_group" "was" {
  name                = "${var.project_name_prefix}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    source_application_security_group_ids = [ azurerm_application_security_group.bastion.id ]
    destination_port_range     = "22"
    destination_application_security_group_ids = [ azurerm_application_security_group.web.id ]
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    source_application_security_group_ids = [ azurerm_application_security_group.int_lb.id ]
    destination_port_range     = "80"
    destination_application_security_group_ids = [ azurerm_application_security_group.was.id ]
  }
}

resource "azurerm_network_security_group" "db" {
  name                = "${var.project_name_prefix}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3306"
    source_application_security_group_ids = [
      azurerm_application_security_group.web.id,
      azurerm_application_security_group.was.id
    ]
    destination_port_range     = "3306"
    destination_application_security_group_ids = [ azurerm_application_security_group.db.id ]
  }
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id = azurerm_subnet.public[*].id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id = azurerm_subnet.web[*].id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "azurerm_subnet_network_security_group_association" "was" {
  subnet_id = azurerm_subnet.was[*].id
  network_security_group_id = azurerm_network_security_group.was.id
}

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id = azurerm_subnet.db[*].id
  network_security_group_id = azurerm_network_security_group.db.id
}