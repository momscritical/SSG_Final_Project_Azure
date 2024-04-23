resource "azurerm_resource_group" "rg" {
  location = "koreacentral"
  name     = "Cluster-rg"
}

resource "azurerm_virtual_network" "VNet" {
    name                = "VNet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["10.111.0.0/16"]

}

resource "azurerm_subnet" "my-aks-subnet-1" {
  name                 = "my-aks-subnet-1"
  virtual_network_name = azurerm_virtual_network.VNet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.111.1.0/16"]
}

resource "azurerm_subnet" "default-nodepool-subnet" {
  name                 = "default-nodepool-subnet"
  virtual_network_name = azurerm_virtual_network.VNet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.111.2.0/16"]
}

resource "azurerm_subnet" "ingress-gateway-subnet-1" {
  name                 = "ingress-gateway-subnet-1"
  virtual_network_name = azurerm_virtual_network.VNet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.111.3.0/16"]
}

resource "azurerm_subnet" "default-pod-subnet" {
  name                 = "default-pod-subnet"
  virtual_network_name = azurerm_virtual_network.VNet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.111.4.0/16"]
}



################################### role ########################################

data "azurerm_client_config" "client_config" {
}

resource "azurerm_role_definition" "custom_role_def" {
  name               = "my-custom-role-definition"
  scope              = azurerm_virtual_network.VNet.id # vnet에만 줄 권한

  permissions {
    actions     = [
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Insights/alertRules/*",
                    "Microsoft.Network/*",
                    "Microsoft.ResourceHealth/availabilityStatuses/read",
                    "Microsoft.Resources/deployments/*",
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Support/*"
                ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "example" {
    name = "role_assignment_for_aks"
    scope              = azurerm_virtual_network.VNet.id
    role_definition_id = azurerm_role_definition.custom_role_def.role_definition_resource_id
    principal_id       = data.azurerm_client_config.client_config.object_id
}

##################################################################################


resource "azurerm_kubernetes_cluster" "our-cluster" {
   name = "our-cluster"    #required
   location = azurerm_resource_group.rg.location    #required
   resource_group_name = azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "basicpool"    #required
 		vm_size = "Standard D2as v4"     #required
# 		capacity_reservation_group_id
# 		custom_ca_trust_enabled
 		enable_auto_scaling = true
 		max_count = 3
 		min_count = 1
 		node_count = 1
# 		enable_host_encrytion
# 		enable_node_public_ip
# 		gpu_instance
# 		host_group_id
# 		kubelet_config {
# 			allowed_unsafed_sysctls
# 			container_log_max_line
# 			container_log_max_size_mb
# 			cpu_cfs_quota_enabled
# 			cpu_cfs_quota_period
# 			cpu_manager_policy
# 			image_gc_high_threshold
# 			image_gc_low_threshold
# 			pod_max_pid
# 			topology_manager_policy
# 		}
# 		linux_os_config {
# 			swap_file_size_mb
# 			sysctl_config {
# 				fs_aio.max_nr
# 				fx_file_max
# 				fx_inotify_max_user_watches
# 				fs_nr_open
# 				kernel_threads_max
# 				net_core_netdev_max_backlog
# 				net_core_optmem_max
# 				net_core_rmem_default
# 				net_core_rmem_max
# 				ner_core_somaxconn
# 				net_core_wmem_default
# 				net_core_wmem_max
# 				net_ipv4_ip_local_port_range_max
# 				net_ipv4_ip_local_port_range_min
# 				net_ipv4_neigh_default_gc_thresh1
# 				net_ipv4_neigh_default_gc_thresh2
# 				net_ipv4_neigh_default_gc_thresh3
# 				net_ipv4_tcp_fin_timeout
# 				net_ipv4_tcp_keepalive_intv1
# 				net_ipv4_tcp_keepalive_probes
# 				net_ipv4_tcp_keepalive_time
# 				net_ipv4_tcp_max_syn_backlog
# 				net_ipv4_tcp_max_tw_buckets
# 				net_ipv4_tcp_tw_reuse
# 				net_netfilter_nf_conntrack_buckets
# 				net_netfilter_nf_conntrack_max
# 				vm_max_map_count
# 				vm_swappiness
# 				vm_vfs_cache_pressure
# 			}
# 			transparent_huge_page_defrag
# 			transparent_huge_page_enabled
# 		}
# 		fips_enabled
# 		kubelet_disk_type
# 		max_pods
# 		message_of_the_day
# 		node_network_profile {
# 			allowed_host_ports {
# 				port_start
# 				port_end
# 				protocol
# 			}
# 			application_security_group_ids
# 			node_public_ip_tags
# 		}
# 		node_public_ip_prefix_id
# 		node_labels
# 		only_critical_addons_enabled
# 		orchestrator_version
# 		os_disk_size_gb
# 		os_disk_type
# 		os_sku
 		pod_subnet_id = azurerm_subnet.default-pod-subnet.id
# 		proximity_placement_group_id
# 		scale_down_mode
# 		snapshot_id
 		temporary_name_for_rotation = "temp_agent"
# 		type
# 		tags
# 		ultra_ssd_enabled
# 		upgrade_settings {
# 			max_surge  #required
#       }
 		vnet_subnet_id = azurerm_subnet.default-nodepool-subnet.id
# 		workload_runtime
# 		zones
    } # EO default_node_pool

#   dns_prefix
#   dns_prefix_private_cluster
#   aci_connector_linux {
# 		subnet_name     #required
#   }
#   automatic_channel_upgrade
#   api_server_access_profile {
# 		authorized_ip_ranges
# 		subnet_id
# 		vnet_integration_enabled
#   }
#   auto_scalar_profile {
# 		balance_similar_node_groups
# 		expander
# 		max_graceful_termination_sec
# 		max_node_provisioning_time
# 		max_unready_nodes
# 		max_unready_percentage
# 		new_pod_scale_up_delay
# 		scale_down_delay_after_add
# 		scale_down_delay_after_delete
# 		scale_down_delay_after_failure
# 		scan_interval
# 		scale_down_unneeded
# 		scale_down_unready
# 		scale_down_utilization_threshold
# 		empty_bulk_delete_max
# 		skip_nodes_with_local_storage
# 		skip_nodes_with_system_pods
#   }

#   azure_active_directory_role_based_access_control {
# 		managed
# 		tenant_id
# 		admin_group_object_ids
# 		azure_rabc_enabled	
# 		client_app_id
# 		server_app_id
# 		erver_app_secret
#   }
#   azure_policy_enabled
#   confidential_computing {
# 	    sgx_quote_helper_enabled    #required
#   }
#   custom_ca_trust_certificates_base64
#   disk_encryption_set_id
#   edge_zone
#   http_application_routing_enabled
    http_proxy_config {
# 		http_proxy
# 		https_proxy
 		no_proxy = [ azurerm_subnet.default-nodepool-subnet.id ]
#           If you specify the default_node_pool[0].vnet_subnet_id,
#           be sure to include the Subnet CIDR in the no_proxy list.
# 		trusted_ca
    }
   identity {
 		type = "SystemAssigned"   #required
   }
#   image_cleaner_enabled
#   image_cleaner_interval_hours
    ingress_application_gateway {
# 		gateway_id
		gateway_name = "our-ingress-gateway-1"
# 		subnet_cidr
 		subnet_id = azurerm_subnet.ingress-gateway-subnet-1.id
   }
#   key_management_service  {
# 		key_vault_key_id
# 		key_vault_network_access
#   }
#   key_vault_secrets_provider {
# 		secret_rotation_enabled
# 		secret_rotation_interval
#   }
#   kubelet_identity {
# 		client_id
# 		object_id
# 		user_assigned_identity_id
#   }
#   kubernetes_version
#   linux_profile {
# 		admin_username
# 		ssh_key { #required
# 			key_data    #required
#       }
#   }
#   local_account_disabled
#   maintenance_window {
# 		allowed {
# 			day
# 			hours
# 		}
# 		not_allowed {
# 			end
# 			start
#       }
#   }
#   maintenance_window_auto_upgrade {
# 		frequency
# 		interval
# 		duration
# 		day_of_week
# 		day_of_month
# 		week_index
# 		start_time
# 		utc_offset
# 		start_date
# 		not_allowed {
# 			end
# 			start
#       }
#   }

#   maintenance_window_node_os {
# 		frequency
# 		interval
# 		duration
# 		day_of_week
# 		day_of_month
# 		week_index
# 		start_time
# 		utc_offset
# 		start_date
# 		not_allowed {
# 			end
# 			start
# 		}
#   }
#   microsoft_defender {
# 		log_analytics_workspace_id  #required
#   }
#   monitor_metrics {
# 		annotation_allowed
# 		labels_allowed
#   }
    network_profile {
 		network_plugin = "kubnet"  #required
# 		network_mode
 		network_policy = "calico"
# 		dns_service_ip
# 		docker_bridge_cidr
# 		ebpf_data_plane
# 		network_plugin_mode
#       outbound_type
 		pod_cidr = azurerm_subnet.my-aks-subnet-1.address_prefixes
# 		pod_cidrs
 		service_cidr = "10.100.10.0/24"
# 		service_cidrs
# 		ip_versions
 		load_balancer_sku = "standard"
# 		load_balancer_profile {
# 				idle_timeout_in_minutes
# 				managed_outbound_ip_count
# 				managed_outbound_ipv6_count
# 				outbound_ip_address_ids
# 				outbound_ip_prefix_ids
# 				outbound_ports_allocated
#       }
# 		nat_gateway_profile {
# 				idle_timeout_in_minutes
# 				manged_outbound_ip_count
#       }
   }
#   node_os_channel_upgrade
#   node_resource_group
#   oidc_issuer_enabled
#   oms_agent {
# 	    log_analytics_workspace_id
# 	    msi_auth_for_monitoring_enabled
#   }
#   open_service_mesh_enabled
#   private_cluster_enabled
#   private_dns_zone_id
#   private_cluster_public_fqdn_enabled
    service_mesh_profile {
   	    mode = "Istio" #required
       	internal_ingress_gateway_enabled = true
    	external_ingress_gateway_enabled = true
   }
#   workload_autoscaler_profile {
#   	keda_enabled
#   	vertical_pod_autoscaler_enabled
#   }
#   workload_identity_enabled
#   public_network_access_enabled
#   role_based_access_control_enabled
#   run_command_enabled
#   service_pricipal {
# 	    client_id
# 	    client_secret
#   }
#   sku_tier
#   storage_profile {
# 	    blob_driver_enabled
# 	    disk_driver_enabled
# 	    disk_driver_version
# 	    file_driver_enabled
# 	    snapshot_controller_enabled
#   }
#   support_plan
#   tags
#   web_app_routing {
#       dns_zone_id #required
#   }
#   windows_profile {
# 	    admin_username  #required
# 	    admin_password
# 	    license
# 	    gmsa {
# 		    dns_server  #required
# 		    root_domain  #required
# 	    }
#   }		
}