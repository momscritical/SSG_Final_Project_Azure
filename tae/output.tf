output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.bastion.public_ip_address
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}


#################################################################################################
# output "resource_group_name" {
#     description = "The name of the created resource group."
#     value = azurerm_resource_group.rg.name
# }

# output "virtual_network_name" {
#     description = "The name of the created virtual network."
#     value = azurerm_virtual_network.my_terraform_network.name
# }

# output "subnet_name_1" {
#     description = "The name of the created subnet 1."
#     value = azurerm_subnet.my_terraform_subnet_1.name
# }

# output "subnet_name_2" {
#     description = "The name of the created subnet 2."
#     value = azurerm_subnet.my_terraform_subnet_2.name
# }