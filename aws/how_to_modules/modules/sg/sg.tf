resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "My sg"
  vpc_id      = "vpc-123"

  tags        = {
    Name          = "my_sg"
  }

}

output "my_sg"   { value = aws_security_group.my_sg.id }
