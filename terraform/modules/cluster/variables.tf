variable "eks_cluster" {
  type    = string
  default = "three-edges-cluster"
}

variable "eks_node_group" {
  type    = string
  default = "three-edges-node-group"
}