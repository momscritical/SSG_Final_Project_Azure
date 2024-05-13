## azure ip
# 10.1.0.0/16 : virtual network
# 10.1.1.0/24 : GatewaySubnet
# 10.1.2.0/24 : endpoint subnet ( SQL server, Storage )
# DO NOT SET [delegate subnet] when you need private endpoint
# 10.1.10.0/24 : basic subnet (for aks)
# 10.1.11.0/24 : service subnet (for aks)

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
variable "az_ep" {
    type = object({
        prefix = string
        sub_ip_address = string
        sub_service_endpoints = list(string)
        storage_static_name = string
        storage_static_ip = string
        db_static_name = string
        db_static_ip = string
    })
    description = "endpoint subnet data"
    default = {
        prefix = "ep"
        sub_ip_address = "10.1.2.0/24"
        sub_service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
        storage_static_name = "storage_static_ip"
        storage_static_ip = "10.1.2.100"
        db_static_name = "db_static_ip"
        db_static_ip = "10.1.2.101"
    }
}
variable "db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
  default = "azureroot"
  sensitive   = true
}
variable "db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  default = "admin12345!!"
  sensitive   = true
}

