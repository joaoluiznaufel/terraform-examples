resource "aws_subnet" "private-subnet" {
  vpc_id                  = "vpc-81723"
  cidr_block              = "172.45.5.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}

output "private_subnet_id"   { value = aws_subnet.private-subnet.id }
