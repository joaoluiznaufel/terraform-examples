resource "aws_internet_gateway" "example-igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Project     = "My VPC"
    Environment = "production"
  }
}