
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
        rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/gIDP_admin"
        username = "gIDP_admin"
        groups = [
          "system:masters"
        ]
      },
      {
        rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.eks_node_role}"
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

locals {
  oidc_issuer = var.aws_eks_cluster_eks_cluster_identity[0].oidc[0].issuer
}

locals {
  split_oidc_issuer = split("id/", local.oidc_issuer)
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.11.1"
  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
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

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "3edges"
  }
}

module "deployments" {
  source        = "./deployments"
  k8s_namespace = kubernetes_namespace.namespace
  cert_manager  = helm_release.cert_manager.name
  hosted_zone                     = var.hosted_zone
  aws_region                      = var.aws_region
  aws_route53_zone_hosted_zone_id = var.aws_route53_zone_hosted_zone_id
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "v1.12.3"

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "cert-manager"
  }

  set {
    name  = "rbac.create"
    value = "false"
  }

  create_namespace = true
}

resource "aws_iam_role" "cert_manager_role" {
  name = "cert-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.ca-west-1.amazonaws.com/id/${local.split_oidc_issuer[1]}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "oidc.eks.ca-west-1.amazonaws.com/id/${local.split_oidc_issuer[1]}:sub" = "system:serviceaccount:cert-manager:cert-manager"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role     = aws_iam_role.cert_manager_role.name
}

resource "kubernetes_service_account" "cert_manager" {
  metadata {
    name      = "cert-manager"
    namespace = "cert-manager"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cert_manager_role.arn
    }
  }
}

resource "aws_iam_role_policy" "cert_manager_policy" {
  name   = "cert-manager-policy"
  role   = aws_iam_role.cert_manager_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:ListHostedZones"
        ],
        Resource = "*"
      }
    ]
  })
}
