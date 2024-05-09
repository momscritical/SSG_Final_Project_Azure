# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.az_prefix}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZone${var.az_prefix}.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.private_dns_zone
  ]
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
    name                   = "${var.az_prefix}-mysql-flexible-server"
    resource_group_name    = azurerm_resource_group.rg.name
    location               = azurerm_resource_group.rg.location
    # delegated_subnet_id    = azurerm_subnet.db_subnet.id
    administrator_login    = var.db_admin.login
    administrator_password = var.db_admin.pwd
    private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
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
    subnet_id           = azurerm_subnet.basic_subnet.id

    private_service_connection {
        name                           = "${var.az_prefix}-connection"
        private_connection_resource_id = azurerm_mysql_flexible_server.mysql_server.id
        subresource_names              = [ "mysqlServer" ]
        is_manual_connection           = false
    }
    ip_configuration {
        name = "private_ip_for_db"
        private_ip_address = var.az_basic.private_ip
        subresource_name = "mysqlServer" 
        # 위쪽 블럭의  subresource_names에 맞춰서 써야?
    }
    private_dns_zone_group {
        name                 = "${var.az_prefix}-dns-zone-group"
        private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone.id]
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ 
        azurerm_mysql_flexible_server.mysql_server
    ]
}



