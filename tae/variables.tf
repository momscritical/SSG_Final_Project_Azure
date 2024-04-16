variable "resource_group_location" {
    type = string
    default = "East Australia"
    description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
    type = string
    default = "rg"
    description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "web_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "app_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
variable "db_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.201.0/24", "10.0.202.0/24"]
}