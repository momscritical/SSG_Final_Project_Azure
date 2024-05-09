
resource "azurerm_subnet" "basic_subnet" {
    name                 = "${var.az_prefix}_${var.az_basic.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
    address_prefixes     = [var.az_basic.sub_ip_address]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "svc_subnet" {
    name                 = "${var.az_prefix}_${var.az_svc.prefix}_subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_resource_group.rg.name
    address_prefixes     = [var.az_svc.sub_ip_address]
    service_endpoints = var.az_svc.sub_service_endpoints
    lifecycle {
      create_before_destroy = true
    }
}