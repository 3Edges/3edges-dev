# exposing these variables to deployments moudle
output "api_name" {
  value = local.api_name
}

output "PROM_METRICS_PREFIX" {
  value = local.PROM_METRICS_PREFIX
}

# Output the ingress URLS 

output "dataproxy_url" {
  value = kubernetes_ingress_v1.three_edges_client_ingress.spec[0].rule[0].host
}

# output "authz_url" {
#   value = kubernetes_ingress_v1.three_edges_client_ingress.spec[0].rules[1].host
# }

# output "dashboard_url" {
#   value = kubernetes_ingress_v1.three_edges_client_ingress.spec[0].rules[2].host
# }

# output "idp_url" {
#   value = kubernetes_ingress_v1.three_edges_client_ingress.spec[0].rules[3].host
# }