
resource "azurerm_public_ip" "gwpip1" {
    name                = "${var.azure_name_prefix}_gwpip1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
    zones = ["1","2","3"]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_public_ip" "gwpip2" {
    name                = "${var.azure_name_prefix}_gwpip2"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
    zones = ["1","2","3"]
    lifecycle {
      create_before_destroy = true
    }
}