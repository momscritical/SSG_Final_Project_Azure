# built-in role - Storage Account Contributor


data "azurerm_client_config" "cli_conf" {
}

resource "azurerm_role_assignment" "role_sa" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = data.azurerm_client_config.cli_conf.object_id
}

# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "${var.azure_name_prefix}account"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    identity {
        type = "SystemAssigned"
    }
    network_rules {
        default_action             = "Deny"
        virtual_network_subnet_ids = [
            azurerm_subnet.basic_subnet.id,
            azurerm_subnet.web_subnet.id,
            azurerm_subnet.was_subnet.id
        ]
    }
}

###########
resource "azurerm_private_endpoint" "priv_ep_1" {
    name                = "${var.azure_name_prefix}_private_endpoint_1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.basic_subnet.id

    private_service_connection {
        name                           = "priv_conn_for_service_account_1"
        private_connection_resource_id = azurerm_storage_account.sa.id
        is_manual_connection           = false
        subresource_names              = ["blob"]
    }

    lifecycle {
        create_before_destroy = true 
    }
}

resource "azurerm_private_endpoint_application_security_group_association" "priv_ep_asc_1" {
  private_endpoint_id           = azurerm_private_endpoint.priv_ep_1.id
  application_security_group_id = azurerm_application_security_group.str_priv_asg.id
}

resource "azurerm_private_endpoint" "priv_ep_2" {
    name                = "${var.azure_name_prefix}_private_endpoint_2"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.web_subnet.id

    private_service_connection {
        name                           = "priv_conn_for_service_account_2"
        private_connection_resource_id = azurerm_storage_account.sa.id
        is_manual_connection           = false
        subresource_names              = ["blob"]
    }
    lifecycle {
        create_before_destroy = true 
    }
}

resource "azurerm_private_endpoint_application_security_group_association" "priv_ep_asc_2" {
  private_endpoint_id           = azurerm_private_endpoint.priv_ep_2.id
  application_security_group_id = azurerm_application_security_group.str_priv_asg.id
}

resource "azurerm_private_endpoint" "priv_ep_3" {
    name                = "${var.azure_name_prefix}_private_endpoint_3"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id           = azurerm_subnet.was_subnet.id

    private_service_connection {
        name                           = "priv_conn_for_service_account_3"
        private_connection_resource_id = azurerm_storage_account.sa.id
        is_manual_connection           = false
        subresource_names              = ["blob"]
    }
    lifecycle {
        create_before_destroy = true 
    }
}

resource "azurerm_private_endpoint_application_security_group_association" "priv_ep_asc_3" {
  private_endpoint_id           = azurerm_private_endpoint.priv_ep_3.id
  application_security_group_id = azurerm_application_security_group.str_priv_asg.id
}