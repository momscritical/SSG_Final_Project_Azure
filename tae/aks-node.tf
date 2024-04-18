resource "azurerm_kubernetes_cluster_node_pool" "web" {
  count = length(var.web_subnets)
  name                    = "${var.project_name_prefix}-Web-NP-0${count.index + 1}"
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
  vm_size                 = "Standard_LRS"

  enable_node_public_ip  = false
  vnet_subnet_id         = element(azurerm_subnet.web.id, count.index)

  enable_auto_scaling    = true
  scale_down_mode        = "Delete"
  node_count             = 1
  max_count              = 2
  min_count              = 1

  node_taints = [
    "web=true:NoSchedule"
  ]

  node_network_profile {
    application_security_group_ids = [ azurerm_application_security_group.web.id ]
  }

  tags = {
    Name        = "Web-Node"
    Environment = "production"
    ASG-Tag     = "Web-Node"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "was" {
  count = length(var.was_subnets)
  name                    = "${var.project_name_prefix}-WAS-NP-0${count.index + 1}"
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
  vm_size                 = "Standard_LRS"

  enable_node_public_ip  = false
  vnet_subnet_id         = element(azurerm_subnet.was.id, count.index)

  enable_auto_scaling    = true
  scale_down_mode        = "Delete"
  node_count             = 1
  max_count              = 2
  min_count              = 1

  node_taints = [
    "was=true:NoSchedule"
  ]

  node_network_profile {
    application_security_group_ids = [ azurerm_application_security_group.was.id ]
  }

  tags = {
    Name        = "WAS-Node"
    Environment = "production"
    ASG-Tag     = "Was-Node"
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "web" {
#   name                    = "${var.project_name_prefix}-Web-NP"
#   kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
#   vm_size                 = "Standard_LRS"

#   enable_node_public_ip  = false
#   vnet_subnet_id         = azurerm_subnet.web[*].id

#   enable_auto_scaling    = true
#   scale_down_mode        = "Delete"
#   node_count             = 2
#   max_count              = 3
#   min_count              = 1

#   node_taints = [ "web=true:NoSchedule" ]

#   node_network_profile {
#     application_security_group_ids = [ azurerm_application_security_group.web.id ]
#   }

#   tags = {
#     Name        = "Web-Node"
#     Environment = "production"
#     ASG-Tag     = "Web-Node"
#   }
# }

# resource "azurerm_kubernetes_cluster_node_pool" "was" {
#   name                    = "${var.project_name_prefix}-WAS-NP"
#   kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
#   vm_size                 = "Standard_LRS"

#   enable_node_public_ip  = false
#   vnet_subnet_id         = azurerm_subnet.was[*].id

#   enable_auto_scaling    = true
#   scale_down_mode        = "Delete"
#   node_count             = 2
#   max_count              = 3
#   min_count              = 1

#   node_taints = [ "was=true:NoSchedule" ]

#   node_network_profile {
#     application_security_group_ids = [ azurerm_application_security_group.was.id ]
#   }

#   tags = {
#     Name        = "was-Node"
#     Environment = "production"
#     ASG-Tag     = "was-Node"
#   }
# }
