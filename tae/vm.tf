# # Create storage account for boot diagnostics
# resource "azurerm_storage_account" "my_storage_account" {
#   name                     = "diag${random_id.random_id.hex}"
#   location                 = azurerm_resource_group.rg.location
#   resource_group_name      = azurerm_resource_group.rg.name
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# Create virtual machine
resource "azurerm_linux_virtual_machine" "bastion" {
  name                  = "${var.project_name_prefix}-Bastion"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.bastion.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "${var.project_name_prefix}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_HDD"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key =  file("${var.public_key_location}")
  }
}