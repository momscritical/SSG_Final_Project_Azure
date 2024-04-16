variable "resource_group_location" {
    type = string
    default = "Australia East"
    description = "Location of the Resource Group."
}

variable "resource_group_name_prefix" {
    type = string
    default = "rg"
    description = "Resource Group Name of Value"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Subnet CIDR Values for Bastion"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "web_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR Values for Web"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "was_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR Values for WAS"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
variable "db_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR Values for DataBase"
  default     = ["10.0.201.0/24", "10.0.202.0/24"]
}