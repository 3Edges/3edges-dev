output "oidc_provider_url" {
  value = module.cluster.aws_eks_cluster_eks_cluster_identity[0].oidc[0].issuer
}

output "oidc_provider_audience" {
  value = "sts.amazonaws.com"
}
