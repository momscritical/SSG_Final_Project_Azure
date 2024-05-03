
resource "azurerm_public_ip" "nat_gw_pip" {
  name                = "${var.azure_name_prefix}_nat_gw_pip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_nat_gateway" "nat" {
  name                    = "${var.azure_name_prefix}_nat_gw"
  location                = data.azurerm_resource_group.rg.location
  resource_group_name     = data.azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "ngw_asc" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

# 하나의 NAT gateway에 여러 서브넷 장착 가능
resource "azurerm_subnet_nat_gateway_association" "basic_ngw_asc" {
  subnet_id      = azurerm_subnet.basic_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
resource "azurerm_subnet_nat_gateway_association" "web_ngw_asc" {
  subnet_id      = azurerm_subnet.web_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
resource "azurerm_subnet_nat_gateway_association" "was_ngw_asc" {
  subnet_id      = azurerm_subnet.was_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}