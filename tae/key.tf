# resource "azurerm_ssh_public_key" "final_key" {
#   name                = var.key_name
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   public_key          = file("${var.public_key_location}")

#   tags = {
#     Name = var.key_tags
#   }
# }

# resource "azurerm_compute_ssh_key" "public_key" {
#   name = var.key_name
#   location = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   public_key = file("${var.public_key_location}")
# }

# resource "local_file" "public_key_content" {
#   filename = "final-key.pub"
#   content  = azurerm_compute_ssh_key.public_key.public_key
# }