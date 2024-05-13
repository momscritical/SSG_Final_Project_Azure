data "aws_vpc" "vpc" {
    cidr_block = var.aws_vpc_ip_block
    tags = {
        Name = "Final-VPC"
    }
}