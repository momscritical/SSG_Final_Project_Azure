# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.project_name_prefix}-RG"

  tags = {
    Name = "${var.project_name_prefix}-RG"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vn" {
  name                  = "${var.project_name_prefix}-VN"
  address_space         = ["10.0.0.0/16"]
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  
  tags = {
    Name = "${var.project_name_prefix}-VN"
  }

  depends_on = [ azurerm_resource_group.rg ]
}