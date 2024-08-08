output "nginx_ingress_load_balancer_zone_id" {
  value = data.aws_lb.nginx_load_balancer.zone_id
}

output "nginx_ingress_load_balancer_dns_name" {
  value = data.aws_lb.nginx_load_balancer.dns_name
}

output "nginx_ingress_load_balancer_arn" {
  value = data.aws_lb.nginx_load_balancer.arn
}

output "load_balancer_hostname" {
  value = local.load_balancer_hostname
}
