# output "oidc_provider_url" {
#   value = module.cluster.aws_eks_cluster_eks_cluster_identity[0].oidc[0].issuer
# }

# output "oidc_provider_audience" {
#   value = "sts.amazonaws.com"
# }

# output "cluster_config_NGINX_LB" {
#   value = module.kubernetes.aws_lb_nginx_load_balancer["dns_name"]
# }

# local values
# output "configuration_config_CLUSTER_URL" {
#   value = local.configuration_config_CLUSTER_URL
# }

# output "n_client_secret" {
#   value = module.cypher.docker_n_client_secret
# }

output "DOMAIN_URL" {
  value = "https://${var.hosted_zone}"
}


# output "api_authz_url" {
#   value = module.kubernetes.

# }

output "API_SERVICE_URL" {
  value = var.manual_api_deployment ? "https://${module.kubernetes.dataproxy_url}" : "NO MANUAL API DEPLOYMENTS FOUND"
}

output "AUTHORIZATION_SERVICE_URL" {
  value = var.manual_api_deployment ? "https://${module.kubernetes.authz_url}" : "NO MANUAL API DEPLOYMENTS FOUND"
}

output "OIDC_SERVICE_URL" {
  value = var.manual_api_deployment ? "https://${module.kubernetes.idp_url}/oidc" : "NO MANUAL API DEPLOYMENTS FOUND"
}

output "DASHBOARD_URL" {
  value = var.manual_api_deployment ? "https://${module.kubernetes.dashboard_url}" : "NO MANUAL API DEPLOYMENTS FOUND"
}
