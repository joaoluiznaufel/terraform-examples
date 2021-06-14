resource "aws_route_table" "my-route-to-internet" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  route {
    cidr_block                = "172.28.0.0/16"
    vpc_peering_connection_id = "pcx-123123123123"
  }

  route {
    cidr_block                = "172.38.0.0/16"
    vpc_peering_connection_id = "pcx-222222222"
  }

  tags = {
    Name        = "my-route-to-internet"
  }
}

resource "aws_route_table" "my-route-to-internal" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-nat-gateway.id
  }

  route {
    cidr_block                = "172.28.0.0/16"
    vpc_peering_connection_id = "pcx-123123123123"
  }

  route {
    cidr_block                = "172.38.0.0/16"
    vpc_peering_connection_id = "pcx-222222222"
  }

  tags = {
    Name        = "my-route-to-internal"
  }
}