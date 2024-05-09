resource "aws_subnet" "subnet1" {
    vpc_id     = aws_vpc.vpc1.id
    cidr_block = var.aws_subnet_ip_block_1
    availability_zone = "${var.aws_loc}a"
    tags = {
        Name = "${var.aws_prefix}_gateway_subnet"
    }   
    lifecycle {
        create_before_destroy = true
    }
}
