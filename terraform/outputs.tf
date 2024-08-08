output "nginx_ingress_load_balancer_zone_id" {
  value = module.kubernetes.nginx_ingress_load_balancer_zone_id
}

output "nginx_ingress_load_balancer_dns_name" {
  value = module.kubernetes.nginx_ingress_load_balancer_dns_name
}

output "nginx_ingress_load_balancer_arn" {
  value = module.kubernetes.nginx_ingress_load_balancer_arn
}

output "load_balancer_hostname" {
  value = module.kubernetes.load_balancer_hostname
}

output "aws_route53_zone_hosted_zone_id" {
  value = module.route53.aws_route53_zone_hosted_zone_id
}

output "aws_route53_zone_hosted_zone_name" {
  value = module.route53.aws_route53_zone_hosted_zone_name
}