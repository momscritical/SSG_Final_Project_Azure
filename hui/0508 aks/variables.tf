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
        sub_service_endpoints = ["Microsoft.Sql"]
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
        private_ip = "10.1.10.4"
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
## az db
variable "db_admin" {
    type = map(string)
    description = "db secret"
    default = {
        login = "azureroot"
        pwd = "admin12345!!"
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