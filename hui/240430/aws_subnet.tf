resource "aws_subnet" "subnet1" {
    vpc_id     = aws_vpc.vpc1.id
    cidr_block = var.aws_subnet_ip_block
    availability_zone = var.aws_loc
    tags = {
        Name = "${var.aws_name_prefix}_subnet"
    }   
    lifecycle {
        create_before_destroy = true
    }
}