# Create Public IPs for Bastion
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.project_name_prefix}-Public-IP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_version          = "IPv4"
  allocation_method   = "Dynamic"

  tags = {
    Name        = "Final-Public-IP"
    environment = "production"
  }
}

# Create Network Interface for Bastion
resource "azurerm_network_interface" "nic" {
  name                = "${var.project_name_prefix}-NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.project_name_prefix}-nic-conf"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}