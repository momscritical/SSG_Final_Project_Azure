resource "azurerm_application_security_group" "basic_asg" {
    name                = "${var.az_prefix}_${var.az_basic.prefix}_asg"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_application_security_group" "svc_asg" {
    name                = "${var.az_prefix}_${var.az_svc.prefix}_asg"
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}