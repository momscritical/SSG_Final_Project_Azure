resource "azurerm_kubernetes_cluster" "aks_cluster" {
   name = "${var.az_prefix}_cluster"    #required
   location = data.azurerm_resource_group.rg.location    #required
   resource_group_name = data.azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "${var.az_basic.prefix}_pool"    #required
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
        tags = {
            Type = "${var.az_basic.prefix}pool"
        }
    }

    dns_prefix = "${var.az_prefix}Cluster"
    identity {
        type = "SystemAssigned"
    }
    linux_profile {
        admin_username = var.uname
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }
    network_profile {
        network_plugin = "kubenet"  #required
        load_balancer_sku = "standard"
    }
    oidc_issuer_enabled = true ### oidc 사용 가능하도록
    workload_identity_enabled = true ## ???
    node_resource_group = "${var.az_prefix}_node_rg"
}
resource "azurerm_kubernetes_cluster_node_pool" "svc_pool" {
    name                  = "${var.az_svc.prefix}pool"
    kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks_cluster.id
    vm_size               = var.vm_size
    max_count = 3
    min_count = 1
    node_count = 1
    enable_auto_scaling = true
    vnet_subnet_id = data.azurerm_subnet.svc_subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            data.azurerm_application_security_group.svc_asg.id
        ]
 	}
    tags = {
        Type = "${var.az_svc.prefix}pool"
    }
}