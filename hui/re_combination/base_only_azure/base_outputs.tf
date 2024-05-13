
output "storage_private_ip" {
    value = azurerm_private_endpoint.storage_endpoint.ip_configuration[0].private_ip_address
}

output "db_private_ip" {
    value = azurerm_private_endpoint.db_endpoint.ip_configuration[0].private_ip_address
}

output "db_server_public_access_enabled" {
    value = azurerm_mysql_flexible_server.mysql_server.public_network_access_enabled
}
output "storage_access_key" {
    value = azurerm_storage_account.sa.primary_access_key
    sensitive = true
}
output "storage_location" {
    value = azurerm_storage_account.sa.primary_location
}
output "primary_blob_endpoint" {
    value = azurerm_storage_account.sa.primary_blob_endpoint
}
output "primary_connection_string" {
    value = azurerm_storage_account.sa.primary_connection_string
    sensitive = true
}

