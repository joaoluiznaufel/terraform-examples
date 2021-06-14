resource "aws_subnet" "my-public-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "172.28.0.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-public-a"
  }
}

output "subnet_public_a_id"   { value = aws_subnet.my-public-a.id }

resource "aws_subnet" "my-private-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "172.28.3.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = {
    Name                                     = "my-private-a"
  }
}

output "subnet_private_a_id"   { value = aws_subnet.my-private-a.id }
