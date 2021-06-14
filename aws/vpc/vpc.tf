resource "aws_vpc" "aws_my_vpc" {
  cidr_block                       = "172.38.0.0/16"
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name                               = "aws-my-vpc"
  }
}

output "aws_my_vpc_id"   { value = aws_vpc.aws_my_vpc.id }