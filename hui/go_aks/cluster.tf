

resource "azurerm_kubernetes_cluster" "yeah-cluster" {
   name = "yeah-cluster"    #required
   location = azurerm_resource_group.rg.location    #required
   resource_group_name = azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "basicpool"    #required
 		vm_size = "standard_d2as_v4"     #required
# 		capacity_reservation_group_id
# 		custom_ca_trust_enabled
 		enable_auto_scaling = true
 		max_count = 3
 		min_count = 1
 		node_count = 1
 		max_pods = 30
 		node_network_profile {
 			application_security_group_ids = [ 
                azurerm_application_security_group.default-pool-asg.id
            ]
 		}
 		temporary_name_for_rotation = "temp"
 		vnet_subnet_id = azurerm_subnet.default-nodepool-subnet.id
    }

    dns_prefix = "ourCluster"
    identity {
        type = "SystemAssigned"
    }
    depends_on = [
      azurerm_role_assignment.base
    ]

    ingress_application_gateway {
		gateway_name = "our-ingress-gateway-1"
 		subnet_id = azurerm_subnet.ingress-gateway-subnet-1.id
   }
#   linux_profile {
# 		admin_username
# 		ssh_key { #required
# 			key_data    #required
#       }
#   }
    network_profile {
      network_plugin = "azure"  #required
      network_policy = "azure"
 	  dns_service_ip = "10.100.10.10"
      outbound_type = "userDefinedRouting"
      service_cidr = "10.100.10.0/24"


   }
    node_resource_group = "yeah-node-rg"
}



resource "azurerm_kubernetes_cluster_node_pool" "yeahpool" {
    name                  = "yeahpool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.yeah-cluster.id
    vm_size               = "standard_d2as_v4"
    max_count = 3
    min_count = 1
    node_count = 1
    enable_auto_scaling = true
    vnet_subnet_id = azurerm_subnet.user-nodepool-subnet.id
    node_network_profile {
        application_security_group_ids = [ 
            azurerm_application_security_group.user-pool-asg.id
        ]
 	}
    tags = {
        Environment = "TestTest"
    }
}