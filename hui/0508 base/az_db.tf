
resource "azurerm_private_dns_zone" "dns_zone_1" {
    name                = "${var.az_prefix}.mysql.database.azure.com"
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_mysql_flexible_server" "mysql_server" {
    name                   = "${var.az_prefix}-mysql-flexible-server"
    resource_group_name    = azurerm_resource_group.rg.name
    location               = azurerm_resource_group.rg.location
    delegated_subnet_id    = azurerm_subnet.db_subnet.id
    administrator_login    = var.db_admin.login
    administrator_password = var.db_admin.pwd
    private_dns_zone_id    = azurerm_private_dns_zone.dns_zone_1.id
    sku_name               = "GP_Standard_D2ds_v4"
}

resource "azurerm_mysql_flexible_database" "example" {
    name                = "exampledb"
    resource_group_name = azurerm_resource_group.rg.name
    server_name         = azurerm_mysql_flexible_server.mysql_server.name
    charset             = "utf8"
    collation           = "utf8_unicode_ci"
}