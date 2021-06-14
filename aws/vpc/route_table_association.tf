resource "aws_route_table_association" "public-association-a" {
  subnet_id      = aws_subnet.my-public-a.id
  route_table_id = aws_route_table.my-route-to-internet.id
}

resource "aws_route_table_association" "private-association-a" {
  subnet_id      = aws_subnet.my-private-a.id
  route_table_id = aws_route_table.my-route-to-internal.id
}