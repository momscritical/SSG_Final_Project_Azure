# 사이트 간 VPN 연결 만들기
resource "aws_vpn_connection" "ToAzureInstance1" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    customer_gateway_id = aws_customer_gateway.ToAzureInstance1.id
    type = aws_customer_gateway.ToAzureInstance1.type
    tunnel1_inside_cidr = var.aws_vpn_conn.tunnel1[0]
    tunnel1_preshared_key = var.preshared_key[0]
    tunnel2_inside_cidr = var.aws_vpn_conn.tunnel1[1]
    tunnel2_preshared_key = var.preshared_key[1]
    tags = {
        Name = var.aws_customer_gw.name[0]
    }
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_vpn_connection" "ToAzureInstance2" {
    vpn_gateway_id = aws_vpn_gateway.AzureGW.id
    customer_gateway_id = aws_customer_gateway.ToAzureInstance2.id
    type = aws_customer_gateway.ToAzureInstance2.type
    tunnel1_inside_cidr = var.aws_vpn_conn.tunnel2[0]
    tunnel1_preshared_key = var.preshared_key[0]
    tunnel2_inside_cidr = var.aws_vpn_conn.tunnel2[1]
    tunnel2_preshared_key = var.preshared_key[1]
    tags = {
        Name = var.aws_customer_gw.name[1]
    }
    lifecycle {
        create_before_destroy = true
    }
}

