output "aws_lb_nginx_load_balancer" {
  value = data.aws_lb.nginx_load_balancer
}

output "split_hostname_id" {
  value = local.split_hostname[1]
}

output "dataproxy_url"{
  value = var.manual_api_deployment ? module.deployments.dataproxy_url : ""
}

output "authz_url"{
  value = var.manual_api_deployment ? module.deployments.authz_url : ""
}

output "dashboard_url"{
  value = var.manual_api_deployment ? module.deployments.dashboard_url : ""
}

output "idp_url"{
  value = var.manual_api_deployment ? module.deployments.idp_url : ""
}