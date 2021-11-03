resource "aws_instance" "my-ec2" {
  ami                     = "i-009090909"
  instance_type           = "t3.micro"
  subnet_id               = var.private_subnet_id
  key_name                = "my-key"
  vpc_security_group_ids  = [var.my_sg]

  iam_instance_profile    = "MyRole"

  tags = {
    Name    = "my-ec2"
  }
}
