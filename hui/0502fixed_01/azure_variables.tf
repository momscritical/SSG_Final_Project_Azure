variable "azure_name_prefix" {
    type = string
    description = "the prefix of many resource name in azure"
    default = "summer"
}
variable "azure_loc" {
    type = string
    description = "Location of the resource group."
    default = "koreacentral"
}
variable "azure_vnet_ip_block" {
    type = string
    description = "cidr block for vnet"
    default = "10.1.0.0/16"
}
variable "azure_frontend" {
    type = map(string)
    description = "the data of frontend"
    default = {
        prefix = "frondend", 
        address_prefix = "10.1.0.0/24"
    }
}
variable "azure_gateway_subnet" {
    type = map(string)
    description = "the data of gateway subnet"
    default = {
        name = "GatewaySubnet", # must be this string
        address_prefix = "10.1.1.0/24"
    }
}
variable "azure_basic" {
    type = map(string)
    description = "the data of basic"
    default = {
        prefix = "basic",
        subnet_address_prefix = "10.1.10.0/24"
    }
}
variable "azure_web" {
    type = map(string)
    description = "the data of web"
    default = {
        prefix = "web",
        subnet_address_prefix = "10.1.11.0/24"
    }
}
variable "azure_was" {
    type = map(string)
    description = "the data of was"
    default = {
        prefix = "was",
        subnet_address_prefix = "10.1.12.0/24"
    }
}
variable "network_role_name" {
    type = string
    description = "role name - network contributor"
    default = "Network Contributor"
}
variable "uname" {
    type = string
    description = "The username for the local account that will be created on the new VM."
    default = "azureuser"
}
variable "vm_size" { 
    type = string
    description = "the spec of the virtual machine"
    default = "standard_d2as_v4"
}
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

# variable "resource_type_vmss"{
#     type = string
#     default = "Microsoft.Compute/virtualMachineScaleSets"
# }