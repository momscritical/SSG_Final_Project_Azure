

resource "azurerm_kubernetes_cluster" "yeah-cluster" {
   name = "yeah-cluster"    #required
   location = azurerm_resource_group.rg.location    #required
   resource_group_name = azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "basicpool"    #required
 		vm_size = "standard_d2as_v4"     #required
 		enable_auto_scaling = true
        max_count = 2
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
                azurerm_application_security_group.basicpool-asg.id
            ]
 		}
 		temporary_name_for_rotation = "temp"
 		vnet_subnet_id = azurerm_subnet.basicpool-subnet.id
    }

    dns_prefix = "yeahCluster"
    identity {
        type = "SystemAssigned"
    }
    depends_on = [
      azurerm_role_assignment.base,
      azurerm_application_security_group.basicpool-asg,
      azurerm_application_security_group.webpool-asg,
      azurerm_application_security_group.waspool-asg
    ]

#     ingress_application_gateway {
# 		gateway_name = "yeah-ingress-gateway-1"
#  		subnet_id = azurerm_subnet.ingress-gateway-subnet.id
#    }
    linux_profile {
        admin_username = var.username
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    network_profile {
        network_plugin = "kubenet"  #required
        load_balancer_sku = "standard"
    }
    node_resource_group = "yeah-node-rg"

    tags = {
        Type = "AKS"
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "webpool" {
    name                  = "webpool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.yeah-cluster.id
    vm_size               = "standard_d2as_v4"
    enable_auto_scaling = true
    max_count = 2
    min_count = 1
    node_count = 1
    vnet_subnet_id = azurerm_subnet.webpool-subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            azurerm_application_security_group.webpool-asg.id
        ]
 	}
}

resource "azurerm_kubernetes_cluster_node_pool" "waspool" {
    name                  = "waspool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.yeah-cluster.id
    vm_size               = "standard_d2as_v4"
    enable_auto_scaling = true
    max_count = 2
    min_count = 1
    node_count = 1
    vnet_subnet_id = azurerm_subnet.waspool-subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            azurerm_application_security_group.waspool-asg.id
        ]
 	}
}