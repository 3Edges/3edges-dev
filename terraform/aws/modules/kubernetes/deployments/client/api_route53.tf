# extracting the root doamin from subdomain
locals {
  domain_parts = split(".", var.hosted_zone)
  root_domain  = length(local.domain_parts) > 2 ? join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts))) : var.hosted_zone

  # Condition to determine if the hosted zone is a root domain or not
  # For example, check if the hosted zone is equal to root_domain
#   is_root_domain = var.hosted_zone == local.root_domain
}

# Look up the existing hosted zone for the parent domain
data "aws_route53_zone" "parent_domain" {
  name = local.root_domain
  private_zone = false
}

# # Conditionally create a new hosted zone if the parent domain doesn't exist
# resource "aws_route53_zone" "hosted_zone" {
#   # count = length(data.aws_route53_zone.parent_domain.id != "" ? [] : [1])  # Only create if not found
#   count = length(data.aws_route53_zone.parent_domain) == 0 ? 1 : 0  # Only create if not found
#   name = local.root_domain
# }

# Use the correct zone ID (either existing or newly created)
locals {
  # zone_id = length(data.aws_route53_zone.parent_domain) > 0 ? data.aws_route53_zone.parent_domain[0].zone_id : aws_route53_zone.hosted_zone[0].id
  zone_id = data.aws_route53_zone.parent_domain.zone_id
}


# Add an A record for the API Service
resource "aws_route53_record" "api_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}.${var.hosted_zone}."  
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  # alias {
  #   zone_id                = var.aws_lb_nginx_load_balancer_zone_id
  #   name                   = var.aws_lb_nginx_load_balancer_dns_name
  #   evaluate_target_health = false
  # }

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the Authz Service
resource "aws_route53_record" "authz_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-authz.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  # alias {
  #   zone_id                = var.aws_lb_nginx_load_balancer_zone_id
  #   name                   = var.aws_lb_nginx_load_balancer_dns_name
  #   evaluate_target_health = false
  # }

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the OIDC Service
resource "aws_route53_record" "oidc_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-idp.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  # alias {
  #   zone_id                = var.aws_lb_nginx_load_balancer_zone_id
  #   name                   = var.aws_lb_nginx_load_balancer_dns_name
  #   evaluate_target_health = false
  # }

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}

# Add an A record for the dashboard Service
resource "aws_route53_record" "dashboard_service_record" {
  zone_id = local.zone_id
  name    = "${local.api_name}-dashboard.${var.hosted_zone}."   
  type    = "CNAME"
  ttl     = 300
  records = [var.aws_lb_nginx_load_balancer_dns_name]

  # alias {
  #   zone_id                = var.aws_lb_nginx_load_balancer_zone_id
  #   name                   = var.aws_lb_nginx_load_balancer_dns_name
  #   evaluate_target_health = false
  # }

  depends_on = [kubernetes_ingress_v1.three_edges_client_ingress]
}