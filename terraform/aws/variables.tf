variable "aws_region" {
  default = "ca-west-1"
}

variable "hosted_zone" {
  default = "3edges.co"
}

variable "eks_cluster" {
  default = "three-edges-cluster-praj"
}

variable "eks_role" {
  default = "three-edges-eks-role-praj"
}

variable "eks_node_role" {
  default = "three-edges-eks-node-role-praj"
}

variable "eks_node_group" {
  default = "three-edges-node-group-praj"
}

variable "eks_vpc" {
  default = "three-edges-eks-vpc-praj"
}

variable "eks_internet_gateway" {
  default = "three-edges-eks-igw-praj"
}

variable "eks_route_table" {
  default = "three-edges-eks-route-table-praj"
}

variable "eks_security_group" {
  default = "three-edges-eks-security-group-praj"
}

variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}
