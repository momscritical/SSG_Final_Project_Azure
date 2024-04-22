variable "aws_location"{
    type = string
    default = "ap-northeast-3a"
}

variable "aws_vpc_info" {
    type = map(string)
    default = {
        name = "VPC1"
        cidr_block = "10.2.0.0/16"
    }
}

variable "aws_subnet_info" {
    type = map(string)
    default = {
        name = "Subnet1"
        cidr_block = "10.2.1.0/24"
    }
}

variable "aws_route_table_info" {
    type = map(string)
    default = {
        name = "RouteTable1"
    }
}

variable "aws_vpn_gateway_info" {
    type = map(string)
    default = {
        name = "AzureGW"
        amazon_side_asn = "64512"
    }
}
