##### az
variable "az_prefix" {
    type = string
    description = "name prefix"
    default = "choco"
}
variable "az_loc" {
    type = string
    description = "location"
    default = "koreacentral"
}
variable "az_vnet_ip" {
    type = string
    description = "virtual network ip"
    default = "10.1.0.0/16"
}

## az subnet
variable "az_gw_subnet" {
    type = map(string)
    description = "GatewaySubnet data"
    default = {
        name = "GatewaySubnet"
        address_prefix = "10.1.1.0/24"
    }
}
variable "az_db" {
    type = object({
        prefix = string
        sub_ip_address = string
        sub_service_endpoints = list(string)
    })
    description = "db subnet data"
    default = {
        prefix = "db"
        sub_ip_address = "10.1.2.0/24"
        sub_service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    }
}

variable "az_ingr_app" {
    type = object({
        prefix = string
        sub_ip_address = string
        sub_service_endpoints = list(string)
    })
    description = "ingress application gateway subnet data"
    default = {
        prefix = "az_ingr_app"
        sub_ip_address = "10.1.3.0/24"
        sub_service_endpoints = []
    }
}
variable "az_basic" {
    type = object({
        prefix = string
        sub_ip_address = string
        sub_service_endpoints = list(string)
        private_ip = string
    })
    description = "basic subnet data"
    default = {
        prefix = "basic"
        sub_ip_address = "10.1.10.0/24"
        sub_service_endpoints = []
        private_ip = "10.1.10.10"
    }
}
variable "az_svc" {
    type = object({
        prefix = string
        sub_ip_address = string
        sub_service_endpoints = list(string)
    })
    description = "service subnet data"
    default = {
        prefix = "svc"
        sub_ip_address = "10.1.11.0/24"
        sub_service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
    }
}
## az role
variable "network_role_name" {
    type = string
    description = "role name - network contributor"
    default = "Network Contributor"
}
variable "storage_account_role_name" {
    type = string
    description = "role name - storage account contributor"
    default = "Storage Account Contributor"
}
variable "sql_security_manager_role_name" {
    type = string
    description = "role name - sql security manager"
    default = "SQL Security Manager"
}
variable "sql_server_contributor_role_name" {
    type = string
    description = "role name - sql server contributor"
    default = "SQL Server Contributor"
}
variable "private_dns_zone_contributor_role_name" {
    type = string
    description = "role name - Private DNS Zone Contributor"
    default = "Private DNS Zone Contributor"
}
variable "dns_zone_contributor_role_name" {
    type = string
    description = "role name - DNS Zone Contributor"
    default = "DNS Zone Contributor"
}

## az db
variable "db_admin" {
    type = map(string)
    description = "db secret"
    default = {
        login = "azureroot"
        pwd = "admin12345!!"
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

##### common
variable "preshared_key" {
    type = list(string)
    description = "the key of the preshared key for peering"
    default = ["always_sleepy_0529", "sleepy_always_0529"]
}
variable "ssh_public_key" {
    default = "~/.ssh/final-key.pub"
}
##### aws
variable "aws_prefix" {
    type = string
    description = "name prefix"
    default = "berry"
}
variable "aws_loc" {
    type = string
    description = "location"
    default = "ap-northeast-3"
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
variable "aws_subnet_ip_block_2" {
    type = string
    description = "cidr_block for subnet2"
    default = "10.2.2.0/24"
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