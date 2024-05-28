# Add required role assignment over resource group containing the Azure Monitor Workspace 
resource "azurerm_role_assignment" "grafana" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.graf.identity[0].principal_id
}

# Add role assignment to Grafana so an admin user can log in
resource "azurerm_role_assignment" "grafana-admin" {
  scope                = azurerm_dashboard_grafana.graf.id
  role_definition_name = "Grafana Admin"
  principal_id         = data.azurerm_client_config.client_config.object_id
}