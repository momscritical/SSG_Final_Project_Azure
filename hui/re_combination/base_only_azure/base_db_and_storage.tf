# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "${var.az_prefix}account"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_private_endpoint" "storage_endpoint" {
    name                = "${var.az_prefix}-storage-endpoint"
    location            = var.az_loc
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.ep_subnet.id
    private_service_connection {
        name                           = "${var.az_prefix}-storage-connection"
        private_connection_resource_id = azurerm_storage_account.sa.id
        subresource_names              = [ "blob" ]
        is_manual_connection           = false
    }
    ip_configuration {
        name = var.az_ep.storage_static_name
        private_ip_address = var.az_ep.storage_static_ip
        subresource_name = "blob" 
        # 위쪽 블럭의  subresource_names에 맞춰서 써야?
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ azurerm_storage_account.sa ]
}
resource "azurerm_storage_container" "sc" {
    name                  = "${var.az_prefix}container"
    storage_account_name  = azurerm_storage_account.sa.name
    container_access_type = "private"
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
    name                   = "${var.az_prefix}-mysql-flexible-server"
    resource_group_name    = azurerm_resource_group.rg.name
    location               = azurerm_resource_group.rg.location
    administrator_login    = var.db_username
    administrator_password = var.db_password
    sku_name               = "GP_Standard_D2ds_v4"
    zone = "2"
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_private_endpoint" "db_endpoint" {
    name                = "${var.az_prefix}-db-endpoint"
    location            = var.az_loc
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.ep_subnet.id
    private_service_connection {
        name                           = "${var.az_prefix}-db-connection"
        private_connection_resource_id = azurerm_mysql_flexible_server.mysql_server.id
        subresource_names              = [ "mysqlServer" ]
        is_manual_connection           = false
    }
    ip_configuration {
        name = var.az_ep.db_static_name
        private_ip_address = var.az_ep.db_static_ip
        subresource_name = "mysqlServer" 
        # 위쪽 블럭의  subresource_names에 맞춰서 써야?
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ azurerm_mysql_flexible_server.mysql_server ]
}



