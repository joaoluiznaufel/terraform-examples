data "aws_ami" "my-image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["name of the new image"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["the id of the aws account"] # Canonical
}

resource "aws_instance" "my-instance" {
  ami             = data.aws_ami.my-image.id
  instance_type   = "t3.xlarge"
  subnet_id       = "subnet-1111"
  key_name        = "key-name"
  vpc_security_group_ids = ["sg-11"]
  tenancy = "default"

  tags = {
    Name = "my-instance"
  }
}