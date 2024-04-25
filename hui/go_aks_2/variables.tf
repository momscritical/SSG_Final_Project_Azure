variable "resource_group_location" {
    type = string
    default = "koreacentral"
    description = "Location of the resource group."
}

variable "username" {
    type = string
    description = "The username for the local account that will be created on the new VM."
    default = "azureuser"
}

variable "ssh_public_key" {
    default = "~/.ssh/final-key.pub"
}