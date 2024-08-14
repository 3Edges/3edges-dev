
output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "aws_eks_cluster_auth_token" {
  value = data.aws_eks_cluster_auth.eks_auth.token
}

output "aws_eks_cluster_auth_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "aws_eks_cluster_auth_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "aws_eks_cluster_eks_cluster" {
  value = aws_eks_cluster.eks_cluster
}

output "aws_eks_cluster_eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "aws_eks_cluster_eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "aws_eks_node_group_eks_node_group" {
  value = aws_eks_node_group.eks_node_group
}

output "aws_eks_cluster_eks_cluster_identity" {
  value = aws_eks_cluster.eks_cluster.identity
}
