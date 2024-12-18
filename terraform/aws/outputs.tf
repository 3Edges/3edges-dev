output "DOMAIN_URL" {
  value = "https://${var.hosted_zone}"
}

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
