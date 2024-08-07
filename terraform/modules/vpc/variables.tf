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

variable "eks_security_group" {
  type    = string
  default = "three-edges-eks-security-group"
}