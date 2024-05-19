
# about prometheus
resource "azurerm_monitor_workspace" "mws" {
  name                = "prom-test"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

# about grafana
resource "azurerm_dashboard_grafana" "graf" {
  name                              = "graf-test"
  resource_group_name               = data.azurerm_resource_group.rg.name
  location                          = data.azurerm_resource_group.rg.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true
  identity {
    type = "SystemAssigned"
  }
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.mws.id
  }
}

resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "${var.az_prefix}-${azurerm_monitor_workspace.mws.location}-AKS"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = azurerm_monitor_workspace.mws.location
  kind                = "Linux"
}
