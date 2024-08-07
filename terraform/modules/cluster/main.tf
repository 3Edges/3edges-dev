resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster
  role_arn = var.iam_role_arn

  vpc_config {
    subnet_ids = var.eks_subnet[*].id
  }

  depends_on = [
    var.iam_eks_policy,
    var.iam_eks_vpc_resource_controller_policy,
  ]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_node_group
  node_role_arn   = var.aws_iam_role
  subnet_ids      = var.eks_subnet[*].id

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    var.eks_worker_node_policy,
    var.eks_cni_policy,
    var.ec2_container_registry_readonly,
    var.route53_full_access
  ]
}
resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.1-eksbuild.3"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "kube-proxy"
  addon_version = "v1.30.0-eksbuild.3"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group
  ]
}

resource "aws_eks_addon" "eks_pod_identity" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.0-eksbuild.1"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "coredns"
  addon_version = "v1.11.1-eksbuild.9"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group
  ]
}