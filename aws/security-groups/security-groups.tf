resource "aws_security_group" "example-com" {
  name        = "Example.com"
  description = "Example.com security group"
  vpc_id      = "vpc-1111111"

  tags        = {
    Environment   = "prod"
    Name          = "Example.com"
  }

}