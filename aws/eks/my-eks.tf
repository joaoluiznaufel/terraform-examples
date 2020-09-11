resource "aws_iam_role" "my-eks" {
  name = "my-eks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.my-eks.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.my-eks.name
}

resource "aws_security_group" "my-eks-sg" {
  name        = "my-eks-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = "vpc-111"

  tags = {
    Name = "my-eks-sg"
  }
}

resource "aws_security_group_rule" "my-eks-sg-ingress-1" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks             = ["110.0.0.0/32"]
  security_group_id        = aws_security_group.my-eks-sg.id
  description              = "ingress for machine 1"
}

resource "aws_security_group_rule" "my-eks-sg-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-eks-sg.id
}

resource "aws_eks_cluster" "my-ek-cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.my-eks.arn

  vpc_config {
    security_group_ids      = [aws_security_group.my-eks-sg.id]
    subnet_ids              = ["subnet-1111", "subnet-1112", "subnet-1113", "subnet-1114"]
    endpoint_public_access  = false
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy,
  ]
}