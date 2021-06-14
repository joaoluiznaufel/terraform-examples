resource "aws_vpc_peering_connection" "peering-1" {
  peer_vpc_id   = "vpc-123123"
  vpc_id        = aws_vpc.aws_my_vpc.id

  tags          = {
    "Name" = "VPC1 to VPC2"
  }
}

resource "aws_vpc_peering_connection" "peering-2" {
  peer_vpc_id   = "vpc-222222"
  vpc_id        = aws_vpc.aws_my_vpc.id

  tags          = {
    "Name" = "VPC2 to VPC3"
  }
}
