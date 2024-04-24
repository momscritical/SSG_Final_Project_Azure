resource "azurerm_resource_group" "rg" {
    location = "koreacentral"
    name     = "Cluster-rg"
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_virtual_network" "VNet" {
    name                = "VNet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["10.111.0.0/16"]
    lifecycle {
      create_before_destroy = true
    }
}