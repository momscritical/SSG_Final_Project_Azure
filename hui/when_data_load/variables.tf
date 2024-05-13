### aws

variable "aws_loc" {
    type = string
    description = "location"
    default = "ap-northeast-1"
}
variable "aws_vpc_ip_block" {
    type = string
    description = "virtual network ip"
    default = "10.0.0.0/16"
}