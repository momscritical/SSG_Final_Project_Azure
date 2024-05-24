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