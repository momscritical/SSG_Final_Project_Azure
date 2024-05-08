# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "${var.az_prefix}account"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    identity {
        type = "SystemAssigned"
    }
}

resource "azurerm_storage_container" "sc" {
  name                  = "${var.az_prefix}container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}