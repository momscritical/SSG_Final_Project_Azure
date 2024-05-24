
### azure
variable "az_prefix" {
    type = string
    description = "name prefix"
    default = "need"
}
variable "az_loc" {
    type = string
    description = "location"
    default = "japaneast"
}
variable "az_vnet_ip" {
    type = string
    description = "virtual network ip"
    default = "10.1.0.0/16"
}
variable "az_gw_subnet" {
    type = map(string)
    description = "GatewaySubnet data"
    default = {
        name = "GatewaySubnet"
        address_prefix = "10.1.1.0/24"
    }
}

## peering to aws
variable "vnet_gw"{
    type = map(string)
    description = "the data of the virtual network gateway"
    default = {
        type = "Vpn",
        vpn_type = "RouteBased"
        sku = "VpnGw2AZ"
        generation = "Generation2"
    }
}
variable "azure_asn" {
    type = number
    description = "the ASN for bgp on azure"
    default = 65000
    sensitive = true
}
variable "azure_peering_1" { 
    type = object({
      ip_configuration_name = string,
      apipa_bgp_addresses = list(string),
      bgp_addresses = list(string)
    })
    description = "peering1 information"
    default = {
        ip_configuration_name = "VNet1GWConfig1",
        apipa_bgp_addresses = ["169.254.21.2", "169.254.22.2"],
        bgp_addresses = ["169.254.21.1", "169.254.22.1"]
    }
}
variable "azure_peering_2" { 
    type = object({
      ip_configuration_name = string,
      apipa_bgp_addresses = list(string),
      bgp_addresses = list(string)
    })
    description = "peering2 information"
    default = {
        ip_configuration_name = "VNet1GWConfig2",
        apipa_bgp_addresses = ["169.254.21.6", "169.254.22.6"],
        bgp_addresses = ["169.254.21.5", "169.254.22.5"]
    }
}
variable "vnet_ngw_conn_type"{
    type = string
    description = "the type of the virtual network gateway connection"
    default = "IPsec" # IPsec means "site-to-site"
}

### common
variable "preshared_key" {
    type = list(string)
    description = "the keys of the preshared key for peering"
    default = ["always_sleepy_0529", "sleepy_always_0529"]
    sensitive = true
}
### aws
variable "aws_prefix" {
    type = string
    description = "name prefix"
    default = "Final"
}
variable "aws_loc" {
    type = string
    description = "location"
    default = "ap-northeast-2"
}
variable "aws_vpc_ip_block" {
    type = string
    description = "virtual network ip"
    default = "10.2.0.0/16"
}
variable "aws_subnet_ip_block_1" {
    type = string
    description = "cidr_block for subnet1"
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
    sensitive = true
}
variable "aws_vpn_conn" {
    type = map(any)
    description = "the data of the vpn connection"
    default = {
        tunnel1 = ["169.254.21.0/30", "169.254.22.0/30"],
        tunnel2 = ["169.254.21.4/30", "169.254.22.4/30"]
    }
}