resource "azurerm_kubernetes_cluster" "cluster" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.project_name_prefix}-AKS-Cluster"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.project_name_prefix}-AKS-Cluster"
  kubernetes_version =  "1.29"  

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    vm_size    = "standard_d2as_v4"
    node_count = 1
    enable_auto_scaling = false
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = file("${var.public_key_location}")
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    network_policy     = "calico" 
    load_balancer_sku = "standard"
    pod_cidr       = "10.0.0.0/16"
    service_cidr   = "10.240.0.0/16"
    dns_service_ip = "10.240.0.10"
  }

  tags = {
    Name = "${var.project_name_prefix}-Cluster"
  }
}