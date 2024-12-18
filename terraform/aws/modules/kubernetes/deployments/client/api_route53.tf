# extracting the root doamin from subdomain
locals {
  domain_parts = split(".", var.hosted_zone)
  root_domain  = length(local.domain_parts) > 2 ? join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts))) : var.hosted_zone

}

# Look up the existing hosted zone for the parent domain
data "aws_route53_zone" "parent_domain" {
  name = local.root_domain
  private_zone = false
}


# Use the correct zone ID (either existing or newly created)
locals {
  zone_id = data.aws_route53_zone.parent_domain.zone_id
}


# Add an A record for the API Service
resource "aws_route53_record" "api_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}.${var.hosted_zone}."  
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the Authz Service
resource "aws_route53_record" "authz_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-authz.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the OIDC Service
resource "aws_route53_record" "oidc_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-idp.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the dashboard Service
resource "aws_route53_record" "dashboard_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-dashboard.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}