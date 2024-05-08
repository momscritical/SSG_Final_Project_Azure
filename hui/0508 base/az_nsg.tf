resource "azurerm_network_security_group" "nsg" {
    name                = "${var.az_prefix}_nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
        create_before_destroy = true
    }
}
