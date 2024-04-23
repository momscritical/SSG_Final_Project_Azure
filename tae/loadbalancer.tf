######################################## External ########################################
# Create Public IPs for External Load Balancer
resource "azurerm_public_ip" "elb" {
  name                = "${var.project_name_prefix}-ELB-Public-IP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_version          = "IPv4"
  allocation_method   = "Dynamic"

  tags = {
    Name        = "${var.project_name_prefix}-ELB-Public-IP"
    environment = "production"
  }

  depends_on = [ azurerm_resource_group.rg ]
}

# Create External Load Balancer
resource "azurerm_lb" "ext" {
  name                = "${var.project_name_prefix}-ELB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  # SKU는 LB의 서비스 계층(타입?)
  # "Standard" = 고급 로드 밸런싱 기능 제공 => 자세한 사항은 노션

  frontend_ip_configuration {
    name                 = "${var.project_name_prefix}-ELB-Public-IP-Address"
    public_ip_address_id = azurerm_public_ip.elb.id
  }

  depends_on = [ azurerm_public_ip.elb ]
}

resource "azurerm_lb_backend_address_pool" "ext" {
  loadbalancer_id = azurerm_lb.ext.id
  name            = "${var.project_name_prefix}-ELB-BEAP"

  depends_on = [ azurerm_lb.ext ]
}

# Similar to Healthy Check ?
resource "azurerm_lb_probe" "ext" {
  loadbalancer_id     = azurerm_lb.ext.id
  name                = "${var.project_name_prefix}-Ext-Probe"
  port                = 32706
  interval_in_seconds       = 15
  number_of_probes          = 2

  depends_on = [ azurerm_lb.ext ]
}

# Routing Rule from FrontEnd to BackEnd (Similar to AWS Listener?)
resource "azurerm_lb_rule" "ext" {
  loadbalancer_id                = azurerm_lb.ext.id
  name                           = "${var.project_name_prefix}-ELB-Rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 32706
  disable_outbound_snat          = true
  # 백엔드의 IP가 로드 밸런서 공용 IP로 매핑 => 외부 소스가 백엔드 인스턴스에 직접 접근하지 못함
  frontend_ip_configuration_name = "${var.project_name_prefix}-ELB-Public-IP-Address"
  probe_id                       = azurerm_lb_probe.ext.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext.id]

  depends_on = [
    azurerm_lb.ext,
    azurerm_lb_probe.ext,
    azurerm_lb_backend_address_pool.ext
  ]
}

######################################## Internal ########################################
# Create Internal Load Balancer
resource "azurerm_lb" "int" {
  name                = "${var.project_name_prefix}-ILB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  
  # "Standard" = 고급 로드 밸런싱 기능 제공 => 자세한 사항은 노션
  frontend_ip_configuration {
    name                          = "${var.project_name_prefix}-ELB-Public-IP-Address"
    private_ip_address            = "10.0.1.10"
    private_ip_address_allocation = "Static"
    subnet_id                     = azurerm_subnet.web[0].id
  }
}

resource "azurerm_lb_backend_address_pool" "int" {
  loadbalancer_id = azurerm_lb.int.id
  name            = "${var.project_name_prefix}-ILB-BEAP"

  depends_on = [ azurerm_lb.int ]
}

# Similar to Healthy Check ?
resource "azurerm_lb_probe" "int" {
  loadbalancer_id          = azurerm_lb.int.id
  name                     = "${var.project_name_prefix}-Int-Probe"
  port                     = 30441
  interval_in_seconds      = 15
  number_of_probes         = 2

  depends_on = [ azurerm_lb.int ]
}

# Routing Rule from FrontEnd to BackEnd (Similar to AWS Listener?)
resource "azurerm_lb_rule" "int" {
  name                           = "${var.project_name_prefix}-ILB-Rule"
  loadbalancer_id                = azurerm_lb.int.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 30441
  disable_outbound_snat          = false
  
  # 백엔드의 IP가 로드 밸런서 공용 IP로 매핑 => 외부 소스가 백엔드 인스턴스에 직접 접근하지 못함
  frontend_ip_configuration_name = "${var.project_name_prefix}-ILB-Public-IP-Address"
  probe_id                       = azurerm_lb_probe.int.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.int.id]

  depends_on = [
    azurerm_lb.int,
    azurerm_lb_probe.int,
    azurerm_lb_backend_address_pool.int
  ]
}

# OB Rule은 LB에서 백엔드 인스턴스의 아웃바운드 연결을 제어하는 데 사용
# 백엔드 인스턴스가 외부로 향하는 연결을 어떻게 처리할지 정의
# resource "azurerm_lb_outbound_rule" "ext" {
#   name                    = "${var.project_name_prefix}-ELB-OB"
#   loadbalancer_id         = azurerm_lb.ext.id
#   protocol                = "Tcp"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.ext.id

#   frontend_ip_configuration {
#     name = "${var.project_name_prefix}-ELB-Public-IP-Address"
#   }
# }

# Similar to aws_lb_target_group_attachment ??
# => AKS 만들고 적용
# resource "azurerm_lb_backend_address_pool_address" "ext" {
#   name                    = "${var.project_name_prefix}-ELB-BAPA"
#   backend_address_pool_id = data.azurerm_lb_backend_address_pool.example.id
#   virtual_network_id      = data.azurerm_virtual_network.example.id
#   ip_address              = "10.0.11.0"
# }