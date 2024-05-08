resource "aws_subnet" "subnet1" {
    vpc_id     = aws_vpc.vpc1.id
    cidr_block = var.aws_subnet_ip_block_1
    availability_zone = var.aws_loc
    tags = {
        Name = "${var.aws_prefix}_subnet1"
    }   
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id     = aws_vpc.vpc1.id
    cidr_block = var.aws_subnet_ip_block_2
    availability_zone = var.aws_loc
    tags = {
        Name = "${var.aws_prefix}_subnet2"
    }   
    lifecycle {
        create_before_destroy = true
    }
}