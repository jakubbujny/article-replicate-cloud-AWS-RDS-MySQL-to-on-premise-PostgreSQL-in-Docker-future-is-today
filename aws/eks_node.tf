resource "aws_iam_role" "eks-node" {
  name = "eks-node"

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

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_instance_profile" "eks-node" {
  name = "eks-node"
  role = "${aws_iam_role.eks-node.name}"
}

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon Account ID
}

locals {
  eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' 'eks'
USERDATA
}

resource "aws_launch_configuration" "node" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.eks-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "t2.medium"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = ["${aws_security_group.eks-node.id}"]
  user_data_base64            = "${base64encode(local.eks-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "node" {
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.node.id}"
  max_size             = 1
  min_size             = 1
  name                 = "eks"
  vpc_zone_identifier  = ["${aws_subnet.eks_a.id}"]

  tag {
    key                 = "Name"
    value               = "eks"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/eks"
    value               = "owned"
    propagate_at_launch = true
  }
}

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}