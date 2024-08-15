
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
      # {
      #   rolearn  = aws_iam_role.cert_manager_role.arn
      #   username = "cert-manager"
      #   groups   = ["system:masters"]
      # },
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

# resource "aws_iam_role" "cert_manager_role" {
#   name = "cert-manager-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Federated = "arn:aws:iam::${var.aws_caller_identity_id}:oidc-provider/oidc.eks.${var.aws_region}.amazonaws.com/id/${local.split_hostname[1]}"
#         },
#         Action = "sts:AssumeRoleWithWebIdentity",
#         Condition = {
#           StringEquals = {
#             "oidc.eks.${var.aws_region}.amazonaws.com/id/${local.split_hostname[1]}:sub" = "system:serviceaccount:cert-manager:cert-manager"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
#   role       = aws_iam_role.cert_manager_role.name
# }

# resource "aws_iam_role_policy" "cert_manager_policy" {
#   name = "cert-manager-role-policy"
#   role = aws_iam_role.cert_manager_role.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "route53:ChangeResourceRecordSets",
#           "route53:ListResourceRecordSets",
#           "route53:ListHostedZones"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "cert_manager_policy" {
#   name        = "cert-manager-policy"
#   description = "Policy for cert-manager to access Route 53"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = [
#           "route53:ChangeResourceRecordSets",
#           "route53:ListResourceRecordSets",
#           "route53:ListHostedZones"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment_role" {
#   policy_arn = aws_iam_policy.cert_manager_policy.arn
#   role     = aws_iam_role.cert_manager_role.name
# }

# resource "kubernetes_service_account" "cert_manager" {
#   metadata {
#     name = "cert-manager"
#     namespace = "cert-manager"

#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.cert_manager_role.arn
#     }
#   }

#   depends_on = [ kubernetes_namespace.cert_manager_namespace ]
# }

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

  # set {
  #   name  = "serviceAccount.create"
  #   value = "false"
  # }

  # set {
  #   name  = "serviceAccount.name"
  #   value = kubernetes_service_account.cert_manager.metadata[0].name
  # }

  # set {
  #   name  = "rbac.create"
  #   value = "false"
  # }

  depends_on = [helm_release.ingress_nginx, kubernetes_namespace.cert_manager_namespace,
  # kubernetes_service_account.cert_manager
  ]
}

module "deployments" {
  source = "./deployments"
  cert_manager                    = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  ingress_nginx                   = helm_release.ingress_nginx
  hosted_zone                     = var.hosted_zone
  aws_region                      = var.aws_region
  aws_route53_zone_hosted_zone_id = aws_route53_zone.hosted_zone.id
  kubernetes_namespace_namespace  = kubernetes_namespace.namespace

  providers = {
    kubernetes = kubernetes
  }
}