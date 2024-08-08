
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
        rolearn  = "arn:aws:iam::356300141247:role/gIDP_admin"
        username = "arn:aws:sts::356300141247:assumed-role/gIDP_admin/{{SessionName}}"
        groups = [
          "system:masters"
        ]
      },
      {
        rolearn  = var.arn_node_role
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

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.5"
  namespace        = "cert-manager"
  create_namespace = true

  values = [
    <<EOF
    installCRDs: true
    EOF
  ]
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.6"
  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  values = [
    <<EOF
    controller:
      service:
        type: LoadBalancer
    EOF
  ]
}

resource "aws_route53_record" "idp_lb" {
  zone_id = var.aws_route53_zone_hosted_zone_id
  name    = "idp.${var.aws_route53_zone_hosted_zone_name}"
  type    = "A"

  alias {
    zone_id                = data.aws_lb.nginx_load_balancer.zone_id
    name                   = data.aws_lb.nginx_load_balancer.dns_name
    evaluate_target_health = false
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "aws_route53_record" "cluster_lb" {
  zone_id = var.aws_route53_zone_hosted_zone_id
  name    = "cluster.${var.aws_route53_zone_hosted_zone_name}"
  type    = "A"

  alias {
    zone_id                = data.aws_lb.nginx_load_balancer.zone_id
    name                   = data.aws_lb.nginx_load_balancer.dns_name
    evaluate_target_health = false
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "aws_route53_record" "ingress_nginx" {
  zone_id = var.aws_route53_zone_hosted_zone_id
  name    = var.aws_route53_zone_hosted_zone_name
  type    = "A"

  alias {
    zone_id                = data.aws_lb.nginx_load_balancer.zone_id
    name                   = data.aws_lb.nginx_load_balancer.dns_name
    evaluate_target_health = false
  }

  depends_on = [helm_release.ingress_nginx]
}


# Access (IAM access entries) needs to be (
#   arn:aws:iam::356300141247:role/eks-node-role,
#   arn:aws:iam::356300141247:role/gIDP_admin -> access policy: AmazonEKSClusterAdminPolicy
# )
