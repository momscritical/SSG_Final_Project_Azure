resource "azurerm_subnet" "GatewaySubnet" {
    name                 = var.az_gw_subnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    address_prefixes     = [var.az_gw_subnet.address_prefix]
    lifecycle {
        create_before_destroy = true
    }
}