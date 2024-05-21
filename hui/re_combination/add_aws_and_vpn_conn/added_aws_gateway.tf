# 가상 프라이빗 게이트웨이(vpn gateway) 만들기
resource "aws_vpn_gateway" "AzureGW" {
    vpc_id = aws_vpc.vpc1.id
    amazon_side_asn = var.aws_asn
    tags = {
      Name = "${var.aws_prefix}_AzureGW"
    }
    lifecycle {
        create_before_destroy = true
    }
}

# 경로 전파
# - 가상 프라이빗 게이트웨이(vpn gateway) VPC에 연결
# - 라우팅 테이블에서 라우팅 전파 편집 -> 전파 활성화
resource "aws_vpn_gateway_attachment" "AzureGWAttachment" {
    vpc_id         = aws_vpc.vpc1.id
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id   
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_vpn_gateway_route_propagation" "AzureGWPropagation" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    route_table_id = data.aws_route_table.rt.id
    lifecycle {
        create_before_destroy = true
    }
}
# 고객 게이트웨이 만들기
resource "aws_customer_gateway" "ToAzureInstance1" {
    bgp_asn    = var.azure_asn # Azure VPN 게이트웨이의 ASN
    ip_address = azurerm_public_ip.gwpip1.ip_address # Azure VPN의 첫번째 공용 IP
    type       = var.aws_customer_gw.type
    tags = {
      Name = var.aws_customer_gw.name[0]
    }
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_customer_gateway" "ToAzureInstance2" {
    bgp_asn    = var.azure_asn # Azure VPN 게이트웨이의 ASN
    ip_address = azurerm_public_ip.gwpip2.ip_address # Azure VPN의 두번째 공용 IP
    type       = var.aws_customer_gw.type
    tags = {
      Name = var.aws_customer_gw.name[1]
    }
    lifecycle {
        create_before_destroy = true
    }
}