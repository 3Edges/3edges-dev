variable "eks_cluster" {}

variable "eks_subnet" {
  type = list(any)
}

variable "eks_node_group" {}

variable "iam_role_arn" {}

variable "iam_eks_policy" {}

variable "iam_eks_vpc_resource_controller_policy" {}

variable "aws_iam_role" {}

variable "eks_worker_node_policy" {}

variable "eks_cni_policy" {}

variable "ec2_container_registry_readonly" {}

variable "route53_full_access" {}
