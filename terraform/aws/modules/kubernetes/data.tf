data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = helm_release.ingress_nginx.namespace
  }
}

locals {
  load_balancer_hostname = data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
}

locals {
  split_hostname = split("-", local.load_balancer_hostname)
}

data "aws_lb" "nginx_load_balancer" {
  name = local.split_hostname[0]
  # count = local.load_balancer_hostname == "" ? 0 : 1
}