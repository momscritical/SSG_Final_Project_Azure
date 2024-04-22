resource "azurerm_resource_group" "rg" {
  location = "koreacentral"
  name     = "Cluster-rg"
}

resource "azurerm_virtual_network" "VNet" {
    name                = "VNet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["10.10.0.0/16"]

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


resource "azurerm_subnet" "system-subnet" {
  name                 = "system-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.rg.name
  address_prefixes     = ["10.10.1.0/24"]
}
resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.rg.name
  address_prefixes     = ["10.10.2.0/24"]
}
resource "azurerm_subnet" "was-subnet" {
  name                 = "was-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.rg.name
  address_prefixes     = ["10.10.3.0/24"]
}


resource "azurerm_kubernetes_cluster" "k8s" {
    location            = azurerm_resource_group.rg.location
    name                = "KCluster"
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix          = "KC"

    identity {
        type = "SystemAssigned"
    }

    default_node_pool {
        name       = "systempool"
        vm_size    = "Standard_D2as_v4"

        vnet_subnet_id = azurerm_subnet.system-subnet.id
        
        enable_auto_scaling = true
        max_count = 3
        min_count = 2
        node_count = 2
        
        tags = {
            NodeName = "system"
        }

    }
    linux_profile {
        admin_username = "azureuser"
        ssh_key {
            key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
        }
    }
    network_profile {
        network_plugin    = "kubenet"
        network_policy = "calico"
        load_balancer_sku = "standard"
    }
    ingress_application_gateway {
        
    }

}

resource "azurerm_kubernetes_cluster_node_pool" "webpool" {
    name                  = "webpool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
    vm_size               = "Standard_D2as_v4"

    node_labels = "web"
    node_network_profile {
        application_security_group_ids = [azurerm_application_security_group.web-app-sg.id]

        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
    }
    
    pod_subnet_id = azurerm_subnet.web-subnet.id
    vnet_subnet_id  = azurerm_subnet.web-subnet.id

    enable_auto_scaling = true
    max_count = 3
    min_count = 1
    node_count = 1

    tags = {
        NodeName = "web"
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "waspool" {
    name                  = "waspool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
    vm_size               = "Standard_D2as_v4"

    node_labels = "was"
    node_network_profile {
        application_security_group_ids = [azurerm_application_security_group.was-app-sg.id]

        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
    }
    
    pod_subnet_id = azurerm_subnet.was-subnet.id
    vnet_subnet_id  = azurerm_subnet.was-subnet.id

    enable_auto_scaling = true
    max_count = 3
    min_count = 1
    node_count = 1

    tags = {
        NodeName = "was"
    }

}