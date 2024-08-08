output "ingress_nginx_load_balancer_zone_id" {
  value = module.kubernetes.ingress_nginx_load_balancer_zone_id
}

output "ingress_nginx_load_balancer_dns_name" {
  value = module.kubernetes.ingress_nginx_load_balancer_dns_name
}

output "ingress_nginx_load_balancer_arn" {
  value = module.kubernetes.ingress_nginx_load_balancer_arn
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
