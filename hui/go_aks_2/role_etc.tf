
resource "azurerm_user_assigned_identity" "base" {
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    name                = "yeah"
    lifecycle {
      create_before_destroy = true
    }
}


################################## role ########################################

data "azurerm_client_config" "client_config" {
}

resource "azurerm_role_assignment" "base" {
    scope              = azurerm_virtual_network.VNet.id
    role_definition_name = "Network Contributor"
    principal_id       = data.azurerm_client_config.client_config.object_id
    lifecycle {
      create_before_destroy = true
    }
}

##################################################################################