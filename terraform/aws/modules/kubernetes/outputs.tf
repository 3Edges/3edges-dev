output "ingress_nginx_load_balancer_dns_name" {
  value = data.aws_lb.nginx_load_balancer.dns_name
}

output "ingress_nginx_load_balancer_arn" {
  value = data.aws_lb.nginx_load_balancer.arn
}

output "load_balancer_hostname" {
  value = local.load_balancer_hostname
}

output "k8s_namespace" {
  value = kubernetes_namespace.namespace.metadata[0].name
}

output "aws_caller_identity_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "extract_oidc_provider_id" {
  value = local.split_oidc_issuer[1]
}

output "aws_eks_cluster_identity_issuer" {
  value = var.aws_eks_cluster_eks_cluster_identity[0].oidc[0].issuer
}
