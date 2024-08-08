variable "eks_cluster" {
  type    = string
  default = "three-edges-cluster"
}

variable "eks_node_group" {
  type    = string
  default = "three-edges-node-group"
}

variable "iam_role_arn" {
  type = string
}

variable "iam_eks_policy" {
  type = string
}

variable "iam_eks_vpc_resource_controller_policy" {
  type = string
}

variable "aws_iam_role" {
  type = string
}

variable "eks_subnet" {
  type = list(any)
}

variable "eks_worker_node_policy" {
  type = string
}

variable "eks_cni_policy" {
  type = string
}

variable "ec2_container_registry_readonly" {
  type = string
}

variable "route53_full_access" {
  type = string
}
