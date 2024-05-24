resource "azurerm_role_assignment" "storage_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.storage_account_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ ]
}
resource "azurerm_role_assignment" "sql_security_manager_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.sql_security_manager_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ ]
}
resource "azurerm_role_assignment" "sql_server_contributor_storage_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.sql_server_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ ]
}
resource "azurerm_role_assignment" "private_dns_zone_contributor_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.private_dns_zone_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ ]
}
resource "azurerm_role_assignment" "dns_zone_contributor_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.dns_zone_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ ]
}