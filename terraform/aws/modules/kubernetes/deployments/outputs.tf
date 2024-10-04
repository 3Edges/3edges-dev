# Use the output from the client module
output "api_name_from_client" {
  value = var.manual_api_deployment ? module.client[0].api_name : "" 
}

output "PROM_METRICS_PREFIX_from_client" {
  value = var.manual_api_deployment ? module.client[0].PROM_METRICS_PREFIX : ""  
}

output "dataproxy_url"{
  value = var.manual_api_deployment ? module.client[0].dataproxy_url : ""
}

output "authz_url"{
  value = var.manual_api_deployment ? module.client[0].authz_url : ""
}

output "dashboard_url"{
  value = var.manual_api_deployment ? module.client[0].dashboard_url : ""
}

output "idp_url"{
  value = var.manual_api_deployment ? module.client[0].idp_url : ""
}