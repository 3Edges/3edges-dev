#########################################
#      3Edges Cloud Deployment          #
# These Terraform scripts deploy 3Edges #
# In the selected Cloud.                #
#                                       #
# Update the variables below with the   #
# right values for your environment.    #
#                                       #
# copyright 3edges, August 2024         #
#########################################

variable "aws_region" {
  default = "ca-west-1"
}

variable "hosted_zone" {
  default = "abotega.com"
}

variable "eks_role" {
  default = "three-edges-eks-role"
}

variable "eks_node_role" {
  default = "three-edges-eks-node-role"
}

variable "eks_cluster" {
  default = "three-edges-cluster"
}

variable "eks_node_group" {
  default = "three-edges-node-group"
}

variable "eks_vpc" {
  default = "three-edges-eks-vpc"
}

variable "eks_internet_gateway" {
  default = "three-edges-eks-igw"
}

variable "eks_route_table" {
  default = "three-edges-eks-route-table"
}

variable "eks_security_group" {
  default = "three-edges-eks-security-group"
}
