# Create Public Load Balancer
resource "azurerm_lb" "ext" {
  name                = "${var.project_name_prefix}-LB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "${var.project_name_prefix}-Public-IP-Address"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "ext" {
  loadbalancer_id = azurerm_lb.ext_lb.id
  name            = "Ext-BackEndAddressPool"
}

# Similar to Healthy Check ?
resource "azurerm_lb_probe" "ext" {
  loadbalancer_id     = azurerm_lb.ext_lb.id
  name                = "${var.project_name_prefix}-Web-Probe"
  port                = 80
}

# Routing Rule from FrontEnd to BackEnd (Similar to AWS Listener?)
resource "azurerm_lb_rule" "ext" {
  loadbalancer_id                = azurerm_lb.my_lb.id
  name                           = "test-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  # 백엔드의 IP가 로드 밸런서 공용 IP로 매핑 => 외부 소스가 백엔드 인스턴스에 직접 접근하지 못함
  frontend_ip_configuration_name = "${var.project_name_prefix}-Public-IP-Address"
  probe_id                       = azurerm_lb_probe.ext.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext.id]
}

# resource "azurerm_lb_outbound_rule" "ext" {
#   name                    = "test-outbound"
#   loadbalancer_id         = azurerm_lb.my_lb.id
#   protocol                = "Tcp"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id

#   frontend_ip_configuration {
#     name = var.public_ip_name
#   }
# }

# resource "azurerm_lb_backend_address_pool_address" "example" {
#   name                    = "example"
#   backend_address_pool_id = data.azurerm_lb_backend_address_pool.example.id
#   virtual_network_id      = data.azurerm_virtual_network.example.id
#   ip_address              = "10.0.0.1"
# }

# `azurerm_lb_backend_address_pool` 리소스는
# **Azure Load Balancer**의 **백엔드 주소 풀**을 관리하는 데 사용됩니다.
# 이 리소스를 사용하는 이유와 주요 기능을 살펴보겠습니다:

# 1. **백엔드 주소 풀 (Backend Address Pool)**:
#    - **백엔드 주소 풀**은 **로드 밸런서**가 관리하는 **백엔드 서버 그룹**입니다.
#    - 로드 밸런서는 이 백엔드 주소 풀을 통해 **인바운드 트래픽**을 분산합니다.

# 2. **`azurerm_lb_backend_address_pool` 리소스 사용 이유**:
#    - 이 리소스를 사용하여 **백엔드 주소 풀을 생성**하고 관리합니다.
#    - 백엔드 주소 풀은 **로드 밸런서의 백엔드 서버 그룹**을 정의하며,
#       이를 통해 **로드 밸런서가 트래픽을 분산**합니다.

# 3. **예시**:
#    - 웹 애플리케이션을 운영하는 경우, **백엔드 주소 풀**은 웹 서버 그룹을 나타냅니다.
#    - 로드 밸런서는 이 백엔드 주소 풀을 통해 웹 서버로 들어오는 트래픽을 분산합니다.

# 이 리소스를 사용하여 **로드 밸런서의 백엔드 서버 그룹을 정의**하고,
# 트래픽을 효율적으로 분산할 수 있습니다.
