# Resource Group
resource "azurerm_resource_group" "rg" {
    location = var.resource_group_location
    name = "Final-RG"
}

# Virtual Network
resource "azurerm_virtual_network" "vn" {
    name = "Final-VN"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}