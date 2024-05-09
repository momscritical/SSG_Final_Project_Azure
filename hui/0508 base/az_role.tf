data "azurerm_client_config" "client_config" {
}

# 생각하기 귀찮아졌기 때문에 virtual network에 권한을 때려박았습니다.
resource "azurerm_role_assignment" "network_role_to_vnet" {
    scope              = azurerm_virtual_network.vnet.id
    role_definition_name = var.network_role_name
    principal_id       = data.azurerm_client_config.client_config.object_id
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_role_assignment" "storage_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.storage_account_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    depends_on = [ 
        azurerm_storage_account.sa
    ]
}
resource "azurerm_role_assignment" "sql_security_manager_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.sql_security_manager_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ 

    # ]
}
resource "azurerm_role_assignment" "sql_server_contributor_storage_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.sql_server_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ 

    # ]
}
resource "azurerm_role_assignment" "private_dns_zone_contributor_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.private_dns_zone_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ 

    # ]
}
resource "azurerm_role_assignment" "dns_zone_contributor_role_to_vnet" {
    scope                = azurerm_virtual_network.vnet.id
    role_definition_name = var.dns_zone_contributor_role_name
    principal_id         = data.azurerm_client_config.client_config.object_id
    # depends_on = [ 

    # ]
}