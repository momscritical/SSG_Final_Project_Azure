resource "aws_vpc" "VPC1" {
    cidr_block = var.aws_vpc_info.cidr_block
    tags = {
        Name = var.aws_vpc_info.name
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_subnet" "Subnet1" {
    vpc_id     = aws_vpc.VPC1.id
    cidr_block = var.aws_subnet_info.cidr_block

    availability_zone = var.aws_location

    tags = {
        Name = var.aws_subnet_info.name
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route_table" "RouteTable1" {
    vpc_id = aws_vpc.VPC1.id
    tags = {
      Name = var.aws_route_table_info.name
    }
  
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route_table_association" "RouteAndSub" {
    subnet_id      = aws_subnet.Subnet1.id
    route_table_id = aws_route_table.RouteTable1.id
  
    lifecycle {
        create_before_destroy = true
    }
}

# 가상 프라이빗 게이트웨이(vpn gateway) 만들기
resource "aws_vpn_gateway" "AzureGW" {
    vpc_id = aws_vpc.VPC1.id
    amazon_side_asn = var.aws_vpn_gateway_info.amazon_side_asn
    tags = {
      Name = var.aws_vpn_gateway_info.name
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

# 경로 전파
# - 가상 프라이빗 게이트웨이(vpn gateway) VPC에 연결
# - 라우팅 테이블에서 라우팅 전파 편집 -> 전파 활성화
resource "aws_vpn_gateway_attachment" "AzureGWAttachment" {
    vpc_id         = aws_vpc.VPC1.id
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_vpn_gateway_route_propagation" "AzureGWPropagation" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    route_table_id = aws_route_table.RouteTable1.id
    
    lifecycle {
        create_before_destroy = true
    }
}

# 고객 게이트웨이 만들기
resource "aws_customer_gateway" "ToAzureInstance0" {
    bgp_asn    = 65000 # Azure VPN 게이트웨이의 ASN
    ip_address = azurerm_public_ip.VNet1GWPip.ip_address # Azure VPN의 첫번째 공용 IP
    type       = "ipsec.1"
    tags = {
      Name = "ToAzureInstance0"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_customer_gateway" "ToAzureInstance1" {
    bgp_asn    = 65000 # Azure VPN 게이트웨이의 ASN
    ip_address = azurerm_public_ip.VNet1GWPip2.ip_address # Azure VPN의 두번째 공용 IP
    type       = "ipsec.1"
    tags = {
      Name = "ToAzureInstance1"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

# 사이트 간 VPN 연결 만들기
resource "aws_vpn_connection" "ToAzureInstance0" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    customer_gateway_id = aws_customer_gateway.ToAzureInstance0.id
    type = aws_customer_gateway.ToAzureInstance0.type

    tunnel1_inside_cidr = "169.254.21.0/30"
    tunnel1_preshared_key = "always_sleepy_0418"

    tunnel2_inside_cidr = "169.254.22.0/30"
    tunnel2_preshared_key = "always_sleepy_0418"

    tags = {
        Name = "ToAzureInstance0"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_vpn_connection" "ToAzureInstance1" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    customer_gateway_id = aws_customer_gateway.ToAzureInstance1.id
    type = aws_customer_gateway.ToAzureInstance1.type

    tunnel1_inside_cidr = "169.254.21.4/30"
    tunnel1_preshared_key = "always_sleepy_0418"

    tunnel2_inside_cidr = "169.254.22.4/30"
    tunnel2_preshared_key = "always_sleepy_0418"

    tags = {
        Name = "ToAzureInstance1"
    }
    
    lifecycle {
        create_before_destroy = true
    }
}

