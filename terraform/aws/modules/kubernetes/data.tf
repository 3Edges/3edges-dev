data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = helm_release.nginx_ingress.namespace
  }
}

locals {
  # load_balancer_hostname = data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].hostname
  load_balancer_hostname = data.kubernetes_service.nginx_ingress
}

# # locals {
# #   split_hostname = split("-", local.load_balancer_hostname)
# # }

data "aws_lb" "nginx_load_balancer" {
  # aa2caa4552db845bbaba16bf72756a34
  # name = local.split_hostname[0]

  # aa2caa4552db845bbaba16bf72756a34-4a79c9c0392856fc.elb.ca-west-1.amazonaws.com
  # name = data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].hostname

  name = "aa2caa4552db845bbaba16bf72756a34"
}
