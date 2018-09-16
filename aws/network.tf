provider "aws" {
  region     = "${local.region}"
}


resource "aws_vpc" "main" {
  cidr_block = "${local.vpc_cidr}"

}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

resource "aws_internet_gateway" "internet" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}


resource "aws_route_table" "internet" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet.id}"
  }

  tags {
    Name = "internet"
  }
}


resource "aws_subnet" "eks_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${local.eks_a}"
  availability_zone = "${local.region}a"

  tags {
    Name = "eks_a"
  }
}


resource "aws_route_table_association" "eks_a" {
  subnet_id = "${aws_subnet.eks_a.id}"
  route_table_id = "${aws_route_table.internet.id}"
}

resource "aws_subnet" "eks_b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${local.eks_b}"
  availability_zone = "${local.region}b"

  tags {
    Name = "eks_b"
  }
}


resource "aws_route_table_association" "eks_b" {
  subnet_id = "${aws_subnet.eks_b.id}"
  route_table_id = "${aws_route_table.internet.id}"
}

resource "aws_subnet" "rds" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${local.rds}"
  availability_zone = "${local.region}a"

  tags {
    Name = "rds"
  }
}


resource "aws_route_table_association" "rds" {
  subnet_id = "${aws_subnet.rds.id}"
  route_table_id = "${aws_route_table.internet.id}"
}

resource "aws_security_group" "eks-cluster" {
  name        = "eks-cluster"
  description = "eks communication"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "eks"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds communication"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${local.vpc_first_2_octets}.0.0/16"]
  }

  tags {
    Name = "rds"
  }
}