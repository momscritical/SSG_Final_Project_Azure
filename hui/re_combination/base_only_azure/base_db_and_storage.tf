# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "ssgpangstorage"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ azurerm_resource_group.rg ]
}
resource "azurerm_private_endpoint" "storage_endpoint" {
    name                = "ssgpang-storage-endpoint"
    location            = var.az_loc
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.ep_subnet.id
    private_service_connection {
        name                           = "azure-storage-connection"
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
    name                  = "ssgpangcontainer"
    storage_account_name  = azurerm_storage_account.sa.name
    # 공개? 접근 범위
    container_access_type = "container"
    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
    name                   = "ssgpang-db-server"
    resource_group_name    = azurerm_resource_group.rg.name
    location               = azurerm_resource_group.rg.location
    administrator_login    = var.db_username
    administrator_password = var.db_password
    sku_name               = "GP_Standard_D2ds_v4"
    zone = "2"
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_mysql_flexible_server_configuration" "setting01" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  value               = "OFF"
  depends_on = [ azurerm_mysql_flexible_server.mysql_server ]
}

resource "azurerm_mysql_flexible_server_configuration" "setting02" {
  name                = "character_set_server"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  value               = "UTF8MB4"
  depends_on = [ azurerm_mysql_flexible_server.mysql_server ]
}

resource "azurerm_mysql_flexible_server_configuration" "setting03" {
  name                = "collation_server"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  value               = "UTF8MB4_GENERAL_CI"
  depends_on = [ azurerm_mysql_flexible_server.mysql_server ]
}

resource "azurerm_private_endpoint" "db_endpoint" {
    name                = "ssgpang-db-endpoint"
    location            = var.az_loc
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.ep_subnet.id
    private_service_connection {
        name                           = "ssgpang-db-connection"
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

resource "azurerm_mysql_flexible_database" "ssgpang" {
  name                = "ssgpang"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_general_ci"
}


