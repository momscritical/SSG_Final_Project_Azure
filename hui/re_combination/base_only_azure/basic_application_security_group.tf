resource "azurerm_application_security_group" "storage_asg" {
    name                = "${var.az_prefix}_${var.az_ep.prefix}_storage_asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_application_security_group" "db_asg" {
    name                = "${var.az_prefix}_${var.az_ep.prefix}_db_asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_private_endpoint_application_security_group_association" "assoc_storage_asg" {
    private_endpoint_id           = azurerm_private_endpoint.storage_endpoint.id
    application_security_group_id = azurerm_application_security_group.storage_asg.id
}
resource "azurerm_private_endpoint_application_security_group_association" "assoc_db_asg" {
    private_endpoint_id           = azurerm_private_endpoint.db_endpoint.id
    application_security_group_id = azurerm_application_security_group.db_asg.id
}