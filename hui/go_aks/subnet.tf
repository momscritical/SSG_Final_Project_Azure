resource "azurerm_subnet" "my-aks-subnet-1" {
    name                 = "my-aks-subnet-1"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.1.0/24"]   
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "default-nodepool-subnet" {
    name                 = "default-nodepool-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.2.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "ingress-gateway-subnet-1" {
    name                 = "ingress-gateway-subnet-1"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.3.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "default-pod-subnet" {
    name                 = "default-pod-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.4.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "user-nodepool-subnet" {
    name                 = "user-nodepool-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.5.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "user-pod-subnet" {
    name                 = "user-pod-subnet"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.6.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "my-aks-subnet-10" {
    name                 = "my-aks-subnet-10"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.10.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_subnet" "agw-subnet-1" {
    name                 = "agw-subnet-1"
    virtual_network_name = azurerm_virtual_network.VNet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = ["10.111.11.0/24"]
    lifecycle {
      create_before_destroy = true
    }
}