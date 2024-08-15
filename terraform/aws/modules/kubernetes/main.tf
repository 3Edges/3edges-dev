
provider "kubernetes" {
  host                   = var.aws_eks_cluster_auth_endpoint
  cluster_ca_certificate = base64decode(var.aws_eks_cluster_auth_certificate)
  token                  = var.aws_eks_cluster_auth_token
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = "arn:aws:iam::${var.aws_caller_identity_id}:role/gIDP_admin"
        username = "gIDP_admin"
        groups = [
          "system:masters"
        ]
      },
      {
        rolearn  = "arn:aws:iam::${var.aws_caller_identity_id}:role/${var.eks_node_role}"
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:nodes",
          "system:bootstrappers"
        ]
      }
    ])
  }
}

provider "helm" {
  kubernetes {
    host                   = var.aws_eks_cluster_auth_endpoint
    cluster_ca_certificate = base64decode(var.aws_eks_cluster_auth_certificate)
    token                  = var.aws_eks_cluster_auth_token
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "3edges"
  }
}

resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.0.6"
  create_namespace = true
  timeout          = "3600"

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  depends_on = [var.aws_eks_node_group_eks_node_group]
}

resource "aws_route53_zone" "hosted_zone" {
  name = "${var.hosted_zone}."
}

resource "aws_route53_record" "route53_wildcard_cname" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = "*.${var.hosted_zone}"
  type    = "CNAME"
  ttl     = 300
  records = [data.aws_lb.nginx_load_balancer.dns_name]

  depends_on = [helm_release.ingress_nginx]
}

resource "aws_route53_record" "ingress_nginx" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = aws_route53_zone.hosted_zone.name
  type    = "A"

  alias {
    zone_id                = data.aws_lb.nginx_load_balancer.zone_id
    name                   = data.aws_lb.nginx_load_balancer.dns_name
    evaluate_target_health = false
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "v1.12.3"
  timeout    = "3600"

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [helm_release.ingress_nginx, kubernetes_namespace.cert_manager_namespace]
}

module "deployments" {
  source                          = "./deployments"
  cert_manager                    = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  ingress_nginx                   = helm_release.ingress_nginx
  hosted_zone                     = var.hosted_zone
  aws_region                      = var.aws_region
  aws_access_key_id               = var.aws_access_key_id
  aws_secret_access_key           = var.aws_secret_access_key
  aws_route53_zone_hosted_zone_id = aws_route53_zone.hosted_zone.id
  kubernetes_namespace_namespace  = kubernetes_namespace.namespace

  providers = {
    kubernetes = kubernetes
  }
}