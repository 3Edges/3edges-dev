output "oidc_provider_url" {
  value = module.cluster.aws_eks_cluster_eks_cluster_identity[0].oidc[0].issuer
}

output "oidc_provider_audience" {
  value = "sts.amazonaws.com"
}

output "cluster_config_NGINX_LB" {
  value = module.kubernetes.aws_lb_nginx_load_balancer["dns_name"]
}

# local values
output "configuration_config_CLUSTER_URL" {
  value = local.configuration_config_CLUSTER_URL
}








