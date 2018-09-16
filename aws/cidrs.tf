locals {
  vpc_first_2_octets = "172.30"
  vpc_cidr = "${local.vpc_first_2_octets}.0.0/16"
  eks_a = "${local.vpc_first_2_octets}.1.0/24"
  eks_b = "${local.vpc_first_2_octets}.2.0/24"
  rds_a = "${local.vpc_first_2_octets}.3.0/24"
  rds_b = "${local.vpc_first_2_octets}.4.0/24"
  region = "eu-west-1"
}