resource "azurerm_kubernetes_cluster" "aks_cluster" {
   name = "${var.azure_name_prefix}_cluster"    #required
   location = data.azurerm_resource_group.rg.location    #required
   resource_group_name = data.azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "${var.azure_basic.prefix}pool"    #required
 		vm_size = var.vm_size     #required
 		enable_auto_scaling = true
 		max_count = 3
 		min_count = 1
 		node_count = 1
 		max_pods = 30
 		node_network_profile {
            allowed_host_ports {
                port_start = 80
                port_end = 80
                protocol = "TCP"
            }
 			application_security_group_ids = [ 
                data.azurerm_application_security_group.basic_asg.id
            ]
 		}
 		temporary_name_for_rotation = "temp"
 		vnet_subnet_id = data.azurerm_subnet.basic_subnet.id
    }

    dns_prefix = "${var.azure_name_prefix}Cluster"
    identity {
        type = "SystemAssigned"
    }
    depends_on = [
      azurerm_role_assignment.base,
      data.azurerm_application_security_group.basic_asg,
      data.azurerm_application_security_group.web_asg,
      data.azurerm_application_security_group.was_asg
    ]
    linux_profile {
        admin_username = var.uname
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }
    network_profile {
        network_plugin = "azure"  #required
        load_balancer_sku = "standard"
    }
    oidc_issuer_enabled = true ### oidc 사용 가능하도록
    workload_identity_enabled = true ## ???
    node_resource_group = "${var.azure_name_prefix}_node_rg"

    ingress_application_gateway {
        gateway_id = azurerm_application_gateway.app_gw.id
    }

}
resource "azurerm_kubernetes_cluster_node_pool" "web_pool" {
    name                  = "${var.azure_web.prefix}pool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
    vm_size               = var.vm_size
    max_count = 3
    min_count = 1
    node_count = 1
    enable_auto_scaling = true
    vnet_subnet_id = data.azurerm_subnet.web_subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            data.azurerm_application_security_group.web_asg.id
        ]
 	}
    tags = {
        Type = "${var.azure_web.prefix}_pool"
    }
}
resource "azurerm_kubernetes_cluster_node_pool" "was_pool" {
    name                  = "${var.azure_was.prefix}pool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
    vm_size               = var.vm_size
    max_count = 3
    min_count = 1
    node_count = 1
    enable_auto_scaling = true
    vnet_subnet_id = data.azurerm_subnet.was_subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            data.azurerm_application_security_group.was_asg.id
        ]
 	}
    tags = {
        Type = "${var.azure_was.prefix}_pool"
    }
}