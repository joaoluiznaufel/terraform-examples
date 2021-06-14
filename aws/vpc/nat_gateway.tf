resource "aws_nat_gateway" "my-nat-gateway" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.my-public-a.id

  tags = {
    Name        = "My NAT gateway"
  }
}