resource "azurerm_subnet" "ep_subnet" {
    name                 = "${var.az_prefix}_${var.az_ep.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.az_ep.sub_ip_address]
    service_endpoints = var.az_ep.sub_service_endpoints 
    lifecycle {
        create_before_destroy = true
    }
}
