
resource "azurerm_network_interface" "aks-nic" {
  name                = "aks-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.default-nodepool-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}



# resource "azurerm_network_interface" "nic" {
#   count               = 2
#   name                = "nic-${count.index+1}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "nic-ipconfig-${count.index+1}"
#     subnet_id                     = azurerm_subnet.backend.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }