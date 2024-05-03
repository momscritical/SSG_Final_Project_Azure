

# storage account
resource "azurerm_storage_account" "sa" {
  name                     = "${var.azure_name_prefix}account"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

    allow_nested_items_to_be_public = false
    public_network_access_enabled = false
    default_to_oauth_authentication = true
    identity {
        type = "SystemAssigned"
    }
    network_rules {
        default_action = "deny"
        virtual_network_subnet_ids = [
            azurerm_subnet.basic_subnet.id,
            azurerm_subnet.web_subnet.id,
            azurerm_subnet.was_subnet.id
        ]
    }
}

resource "azurerm_private_endpoint" "priv_ep" {
    name                = "${var.azure_name_prefix}_private_endpoint"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = data.azurerm_subnet.storage_private_subnet.id

    private_service_connection {
        name                           = "priv_conn_for_service_account"
        private_connection_resource_id = azurerm_storage_account.sa.id
        is_manual_connection           = false
        subresource_names              = ["blob"]
    }

    depends_on = [ 
        azurerm_storage_account.sa
    ]
}

resource "azurerm_private_endpoint_application_security_group_association" "priv_ep_asc" {
  private_endpoint_id           = azurerm_private_endpoint.priv_ep.id
  application_security_group_id = azurerm_application_security_group.str_priv_asg.id
}

