# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "${var.az_prefix}account"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
    network_rules {
        default_action             = "Deny"
        ip_rules                   = [data.http.ip.response_body] # 실행하는 곳의 ip를 집어넣는 코드.
        virtual_network_subnet_ids = [azurerm_subnet.svc_subnet.id]
    }
    identity {
        type = "SystemAssigned"
    }
}

resource "azurerm_storage_container" "sc" {
  name                  = "${var.az_prefix}container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}