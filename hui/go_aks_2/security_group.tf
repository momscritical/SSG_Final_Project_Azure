# asg
resource "azurerm_application_security_group" "basicpool-asg" {
    name                = "basicpool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_application_security_group" "webpool-asg" {
    name                = "webpool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_application_security_group" "waspool-asg" {
    name                = "waspool-asg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}


# nsg
resource "azurerm_network_security_group" "yeah-nsg" {
    name                = "yeah-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_subnet_network_security_group_association" "connect-to-webpool" {
  subnet_id                 = azurerm_subnet.webpool-subnet.id
  network_security_group_id = azurerm_network_security_group.yeah-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "connect-to-waspool" {
  subnet_id                 = azurerm_subnet.waspool-subnet.id
  network_security_group_id = azurerm_network_security_group.yeah-nsg.id
}

resource "azurerm_network_security_rule" "from-web-to-was" {
    name                        = "from-web-to-was"
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.yeah-nsg.name
    priority                    = 300

    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"

    source_port_ranges           = [22,80]
    source_application_security_group_ids = [azurerm_application_security_group.webpool-asg.id]

    destination_port_ranges      = [22,80]
    destination_application_security_group_ids = [azurerm_application_security_group.waspool-asg.id]

    lifecycle {
        create_before_destroy = true
    }
}

resource "azurerm_network_security_rule" "to-web" {
    name                        = "to-web"
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.yeah-nsg.name
    priority                    = 290

    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"

    source_port_ranges           = [22,80]
    source_address_prefix = "AzureLoadBalancer"

    destination_port_ranges      = [22,80]
    destination_application_security_group_ids = [azurerm_application_security_group.webpool-asg.id]

    lifecycle {
        create_before_destroy = true
    }

}


# cluster와 함께 생성된 nsg에 덮어쓰기 시도
resource "azurerm_network_security_rule" "overwrite-web" {
    name                        = data.azurerm_network_security_group.ngs.security_rule[1].name
    resource_group_name         = data.azurerm_resources.aks-nsg.resources[0].resource_group_name
    network_security_group_name = data.azurerm_resources.aks-nsg.resources[0].name
    priority                    = data.azurerm_network_security_group.ngs.security_rule[1].priority

    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"

    source_port_ranges           = [22,80]
    source_address_prefix = "*"

    destination_port_ranges      = [22,80]
    destination_application_security_group_ids = [azurerm_application_security_group.webpool-asg.id]

    depends_on = [
      azurerm_kubernetes_cluster.yeah-cluster
    ]
}

resource "azurerm_network_security_rule" "overwrite-was" {
    name                        = data.azurerm_network_security_group.ngs.security_rule[2].name
    resource_group_name         = data.azurerm_resources.aks-nsg.resources[0].resource_group_name
    network_security_group_name = data.azurerm_resources.aks-nsg.resources[0].name
    priority                    = data.azurerm_network_security_group.ngs.security_rule[2].priority

    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"

    source_port_ranges           = [22,80]
    source_address_prefix = "*"

    destination_port_ranges      = [22,80]
    destination_application_security_group_ids = [azurerm_application_security_group.waspool-asg.id]

    depends_on = [
      azurerm_kubernetes_cluster.yeah-cluster
    ]

}