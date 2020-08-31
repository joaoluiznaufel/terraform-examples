# example of rule using a source security group id
resource "aws_security_group_rule" "example-com-22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "sg-111"
  security_group_id        = aws_security_group.example-com.id
}

# example of egress allow all
resource "aws_security_group_rule" "example-com-allow-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example-com.id
}