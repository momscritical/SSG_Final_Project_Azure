# resource "aws_vpc" "vpc" {
#     cidr_block = var.aws_vpc_ip_block
#     tags = {
#         Name = "${var.aws_prefix}_vpc"
#     }
#     lifecycle {
#         create_before_destroy = true
#     }
# }
