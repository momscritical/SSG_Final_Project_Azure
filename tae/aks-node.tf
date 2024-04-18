locals {
  node_pools = {
    "web-01" = {
      name        = "${var.project_name_prefix}-Web-NP-01"
      subnet_ids  = azurerm_subnet.web[0].id
      taints      = ["web=true:NoSchedule"]
      asg_id      = azurerm_application_security_group.web.id
      tags = {
        Name        = "Web-Node"
        Environment = "production"
        ASG-Tag     = "Web-Node"
    }
    }
    "web-02" = {
      name        = "${var.project_name_prefix}-Web-NP-02"
      subnet_ids  = azurerm_subnet.was[1].id
      taints      = ["was=true:NoSchedule"]
      asg_id      = azurerm_application_security_group.web.id
      tags = {
        Name        = "Web-Node"
        Environment = "production"
        ASG-Tag     = "Web-Node"
    }
    }
    "was-01" = {
      name        = "${var.project_name_prefix}-WAS-NP-01"
      subnet_ids  = azurerm_subnet.was[0].id
      taints      = ["web=true:NoSchedule"]
      asg_id      = azurerm_application_security_group.was.id
      tags = {
        Name        = "WAS-Node"
        Environment = "production"
        ASG-Tag     = "WAS-Node"
    }
    }
    "was-02" = {
      name        = "${var.project_name_prefix}-WAS-NP-02"
      subnet_ids  = azurerm_subnet.was[1].id
      taints      = ["was=true:NoSchedule"]
      asg_id      = azurerm_application_security_group.was.id
      tags = {
        Name        = "WAS-Node"
        Environment = "production"
        ASG-Tag     = "WAS-Node"
    }
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each = local.node_pools

  name                    = each.value.name
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
  vm_size                 = "Standard_LRS"
  enable_node_public_ip   = false
  vnet_subnet_id         = [ each.value.subnet_ids ]
  enable_auto_scaling    = true
  scale_down_mode        = "Delete"
  node_count             = 2
  max_count              = 1
  min_count              = 1
  node_taints             = each.value.taints

  node_network_profile {
    application_security_group_ids = [each.value.asg_id]
  }

  tags = each.value.tags
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
