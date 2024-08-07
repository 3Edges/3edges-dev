variable "aws_region" {
  type    = string
  default = "ca-west-1"
}

variable "eks_cluster" {
  type    = string
  default = "three-edges-cluster"
}


variable "eks_vpc" {
  type    = string
  default = "three-edges-eks-vpc"
}

variable "eks_internet_gateway" {
  type    = string
  default = "three-edges-eks-igw"
}

variable "eks_route_table" {
  type    = string
  default = "three-edges-eks-route-table"
}

variable "eks_role" {
  type    = string
  default = "three-edges-eks-role"
}

variable "eks_node_group" {
  type    = string
  default = "three-edges-node-group"
}

variable "eks_node_role" {
  type    = string
  default = "three-edges-eks-node-role"
}

variable "eks_security_group" {
  type    = string
  default = "three-edges-eks-security-group"
}

variable "hosted_zone" {
  type    = string
  default = "three-edges.io"
}

variable "arn_node_role" {
  type    = string
  default = "arn:aws:iam::356300141247:role/three-edges-eks-node-role"
}
