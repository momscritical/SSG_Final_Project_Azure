resource "azurerm_kubernetes_cluster_node_pool" "web" {
    name = "${var.project_name_prefix}-Web-NP"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster
    vm_size = "Standard_LRS"

    enable_node_public_ip = false
    vnet_subnet_id = azurerm_subnet.web[*].id

    enable_auto_scaling = true
    scale_down_mode = "Delete"
    node_count = 2
    max_count = 3
    min_count = 1

    
    node_taints = [
        {
        key = "web"
        value = "true"
        effect = "NoSchedule"
        }
    ]
    
    node_network_profile {
      application_security_group_ids = azurerm_application_security_group.web.id
    }

    tags = {
        Name = "Web-Node"
        Environment = "production"
        ASG-Tag = "Web-Node"
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "was" {
    name = "${var.project_name_prefix}-WAS-NP"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster
    vm_size = "Standard_LRS"

    enable_node_public_ip = false
    vnet_subnet_id = azurerm_subnet.was[*].id

    enable_auto_scaling = true
    scale_down_mode = "Delete"
    node_count = 2
    max_count = 3
    min_count = 1

    
    node_taints = [
        {
        key = "was"
        value = "true"
        effect = "NoSchedule"
        }
    ]
    
    node_network_profile {
      application_security_group_ids = azurerm_application_security_group.was.id
    }

    tags = {
        Name = "was-Node"
        Environment = "production"
        ASG-Tag = "was-Node"
    }
}