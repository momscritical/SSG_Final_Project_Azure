resource "azurerm_resource_group" "rg" {
    location = var.azure_loc
    name     = "${var.azure_name_prefix}_rg"
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.azure_name_prefix}_vnet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = [var.azure_vnet_ip_block]
    lifecycle {
      create_before_destroy = true
    }
}