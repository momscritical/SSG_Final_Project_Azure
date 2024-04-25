
resource "azurerm_public_ip" "public-ip-1" {
    name                = "public-ip-1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_public_ip" "public-ip-2" {
  name                = "public-ip-2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}