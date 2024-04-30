variable "aws_name_prefix" {
    type = string
    description = "the prefix of many resource name in azure"
    default = "rock"
}
variable "aws_loc"{
    type = string
    default = "ap-northeast-3a"
}
variable "aws_vpc_ip_block" {
    type = string
    description = "cidr block for vpc"
    default = "10.1.0.0/16"
}
variable "aws_subnet_ip_block" {
    type = string
    description = "cidr_block for subnet"
    default = "10.2.1.0/24"
}
variable "aws_customer_gw"{
    type = object({
        type = string,
        name = list(string)
    })
    description = "the data of the customer gateway"
    default = {
      type = "ipsec.1",
      name = ["ToAzureInstance1", "ToAzureInstance2"]
    }
}
variable "aws_asn" {
    type = number
    description = "the ASN on aws"
    default = 64512
}
variable "aws_vpn_conn" {
    type = map(any)
    description = "the data of the vpn connection"
    default = {
        tunnel1 = ["169.254.21.0/30", "169.254.22.0/30"],
        tunnel2 = ["169.254.21.4/30", "169.254.22.4/30"]
    }
}