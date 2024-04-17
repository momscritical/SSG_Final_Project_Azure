# resource "azurerm_resource_group" "example" {
#   name     = "myResourceGroup"
#   location = "East US"
# }

# resource "azurerm_virtual_network" "example" {
#   name                = "myVNET"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_subnet" "example" {
#   name                 = "mySubnet"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_application_security_group" "example" {
#   name                = "myASG"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_network_interface" "example" {
#   name                = "myNIC"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "myNicConfiguration"
#     subnet_id                     = azurerm_subnet.example.id
#     application_security_group_ids = [azurerm_application_security_group.example.id]
#   }
# }

# resource "azurerm_lb" "example" {
#   name                = "myLB"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   frontend_ip_configuration {
#     name                 = "myFrontendIP"
#     public_ip_address_id = azurerm_public_ip.example.id
#   }

#   backend_address_pool {
#     name = "myBackendPool"
#   }

#   probe {
#     name = "myProbe"
#     protocol = "Tcp"
#     port = 80
#   }

#   rule {
#     name                   = "myHTTPRule"
#     protocol               = "Tcp"
#     frontend_port          = 80
#     backend_port           = 80
#     frontend_ip_configuration_name = "myFrontendIP"
#     backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
#     probe_id               = azurerm_lb_probe.example.id
#   }
# }
