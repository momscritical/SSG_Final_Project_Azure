
resource "aws_route_table_association" "RouteAndSub1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = data.aws_route_table.rt.id
    lifecycle {
        create_before_destroy = true
    }
}