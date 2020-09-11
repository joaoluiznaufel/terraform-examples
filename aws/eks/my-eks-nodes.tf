resource "aws_iam_role" "my-eks-nodes" {
  name = "my-eks-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "my-eks-nodes-policy" {
  name        = "my-eks-nodes-policy"
  description = "auto scaling group policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "autoscaling:DescribeTags"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "my-eks-nodes-policy-asg-policy" {
  policy_arn = aws_iam_policy.my-eks-nodes-policy.arn
  role       = aws_iam_role.my-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "my-eks-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "my-eks-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.my-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "my-eks-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "my-eks-nodes-CloudWatchAgentServerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.my-eks-nodes.name
}

resource "aws_eks_node_group" "my-eks-nodes" {
  cluster_name    = aws_eks_cluster.my-ek-cluster.name
  node_group_name = "my-eks-nodes"
  node_role_arn   = aws_iam_role.my-eks-nodes.arn
  subnet_ids      = ["subnet-1233", "subnet-1233", "subnet-1233", "subnet-1233"]
  instance_types  = ["t3.xlarge"]

  scaling_config {
    desired_size = 4
    max_size     = 6
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "my-key"
    source_security_group_ids = [aws_security_group.my-eks-sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.my-eks-nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.my-eks-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.my-eks-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.my-eks-nodes-CloudWatchAgentServerPolicy,
    aws_iam_role_policy_attachment.my-eks-nodes-AmazonEKSWorkerNodePolicy,
  ]

  tags = {
    Name                                     = "my-eks-nodes"
    Project                                  = "My awesome project"
    Environment                              = "prod"
  }

}