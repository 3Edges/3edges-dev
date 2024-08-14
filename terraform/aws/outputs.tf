output "ingress_nginx_load_balancer_dns_name" {
  value = module.kubernetes.ingress_nginx_load_balancer_dns_name
}

output "aws_route53_zone_hosted_zone_id" {
  value = module.route53.aws_route53_zone_hosted_zone_id
}

output "aws_caller_identity_account_id" {
  value = module.kubernetes.aws_caller_identity_account_id
}

output "extract_oidc_provider_id" {
  value = module.kubernetes.extract_oidc_provider_id
}

output "aws_eks_cluster_identity_issuer" {
  value = module.kubernetes.aws_eks_cluster_identity_issuer
}

output "hosted_zone" {
  value = var.hosted_zone
}
