######## modified - begin ########
variable "role_names" {
    type = list(string)
    description = "role name list"
    default = [
        "Contributor",
        "Network Contributor",
        "Storage Account Contributor",
        "Storage Blob Data Contributor",
        "SQL Security Manager",
        "SQL Server Contributor",
        "Private DNS Zone Contributor",
        "DNS Zone Contributor",
        "Azure Kubernetes Service RBAC Admin",
        "Grafana Admin",
        "Monitoring Reader"
    ]
}
######## modified - end ##########