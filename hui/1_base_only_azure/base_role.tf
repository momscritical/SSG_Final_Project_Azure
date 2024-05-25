
######## added - begin ########
# managed id (관리 ID) 생성 및 권한 부여
resource "azurerm_user_assigned_identity" "uai" {
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    name                = "${var.az_prefix}_master_key"
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_role_assignment" "role_assignment_for_master_key" {
    for_each = toset(var.role_names)
    scope                = azurerm_resource_group.rg.id
    role_definition_name = each.value
    principal_id         = azurerm_user_assigned_identity.uai.principal_id
}