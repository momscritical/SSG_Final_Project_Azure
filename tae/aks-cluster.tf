resource "azurerm_kubernetes_cluster" "cluster" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.project_name_prefix}-AKS-Cluster"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.project_name_prefix}-AKS-Cluster"
  # kubernetes_version =  "19.0.4"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    vm_size    = "standard_b2pls_v2"
    node_count = 1
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
    load_balancer_sku = "basic"
  }
}