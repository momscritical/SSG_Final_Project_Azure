# Create Public IPs for Bastion
resource "azurerm_public_ip" "bastion" {
  name                = "${var.project_name_prefix}-Bastion-Public-IP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_version          = "IPv4"
  allocation_method   = "Dynamic"

  tags = {
    Name        = "${var.project_name_prefix}-Bastion-Public-IP"
    environment = "production"
  }

  depends_on = [ azurerm_resource_group.rg ]
}

# Create Network Interface for Bastion
resource "azurerm_network_interface" "bastion" {
  name                = "${var.project_name_prefix}-Bastion-NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.project_name_prefix}-Bastion-conf"
    subnet_id                     =  azurerm_subnet.public[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
  }

  depends_on = [
    azurerm_public_ip.bastion,
    azurerm_subnet.public
  ]
}