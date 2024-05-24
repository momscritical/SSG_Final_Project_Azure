variable "az_prefix" {
    type = string
    description = "name prefix"
    default = "need"
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
variable "uname" {
    type = string
    description = "The username for the local account that will be created on the new VM."
    default = "azureuser"
}
variable "ssh_public_key" {
    default = "~/.ssh/final-key.pub"
}
variable "vm_size" { 
    type = string
    description = "the spec of the virtual machine"
    default = "standard_d2as_v4"
}

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