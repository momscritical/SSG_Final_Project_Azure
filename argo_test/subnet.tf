
resource "azurerm_subnet" "basicpool-subnet" {
    name                 = "basicpool-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.1.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "webpool-subnet" {
    name                 = "webpool-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.2.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "waspool-subnet" {
    name                 = "waspool-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.3.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "ingress-gateway-subnet" {
    name                 = "ingress-gateway-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.4.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "application-gateway-subnet01" {
    name                 = "application-gateway-subnet01"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.5.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}