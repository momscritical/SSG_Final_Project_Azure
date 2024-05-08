variable "az_prefix" {
    type = string
    description = "name prefix"
    default = "choco"
}
variable "vm_size" { 
    type = string
    description = "the spec of the virtual machine"
    default = "standard_d2as_v4"
}
variable "az_basic" {
    type = map(string)
    description = "basic subnet data"
    default = {
        prefix = "basic"
        # sub_ip_address = "10.1.10.0/24"
        # sub_service_endpoints = []
    }
}
variable "az_svc" {
    type = map(string)
    description = "service subnet data"
    default = {
        prefix = "svc"
        # sub_ip_address = "10.1.11.0/24"
        # sub_service_endpoints = ["Microsoft.Storage","Microsoft.Sql"]
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