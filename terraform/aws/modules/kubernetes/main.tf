
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

# resource "null_resource" "cert_manager_annotate" {
#   provisioner "local-exec" {
#     command = <<EOF
#       kubectl annotate crd challenges.acme.cert-manager.io meta.helm.sh/release-name=three-edges-cert-manager 2>/dev/null
#       kubectl annotate crd challenges.acme.cert-manager.io meta.helm.sh/release-namespace=cert-manager 2>/dev/null
#       kubectl label crd challenges.acme.cert-manager.io app.kubernetes.io/managed-by=Helm 2>/dev/null
#       kubectl annotate crd certificaterequests.cert-manager.io meta.helm.sh/release-name=three-edges-cert-manager 2>/dev/null
#       kubectl annotate crd certificaterequests.cert-manager.io meta.helm.sh/release-namespace=cert-manager 2>/dev/null
#       kubectl label crd certificaterequests.cert-manager.io app.kubernetes.io/managed-by=Helm 2>/dev/null
#       kubectl annotate crd certificates.cert-manager.io meta.helm.sh/release-name=three-edges-cert-manager 2>/dev/null
#       kubectl annotate crd certificates.cert-manager.io meta.helm.sh/release-namespace=cert-manager 2>/dev/null
#       kubectl label crd certificates.cert-manager.io app.kubernetes.io/managed-by=Helm 2>/dev/null
#       kubectl annotate crd orders.cert-manager.io meta.helm.sh/release-name=three-edges-cert-manager 2>/dev/null
#       kubectl annotate crd orders.cert-manager.io meta.helm.sh/release-namespace=cert-manager 2>/dev/null
#       kubectl label crd orders.cert-manager.io app.kubernetes.io/managed-by=Helm 2>/dev/null
#       EOF
#   }
# }

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.6"
  namespace        = "ingress-nginx"
  create_namespace = true

  values = [
    <<EOF
    controller:
      service:
        type: LoadBalancer
    EOF
  ]
}

resource "null_resource" "nginx_ingress_annotate" {
  provisioner "local-exec" {
    command = <<EOF
      kubectl annotate ingressclass nginx meta.helm.sh/release-name=nginx-ingress 2>/dev/null
      kubectl annotate ingressclass nginx meta.helm.sh/release-namespace=ingress-nginx 2>/dev/null
      kubectl label ingressclass nginx app.kubernetes.io/managed-by=Helm 2>/dev/null
      EOF
  }
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = "kube-system"
  }
}

output "nginx_ingress_load_balancer_hostname" {
  # value = data.kubernetes_service.nginx_ingress.status[0].load_balancer.ingress[0].hostname
  value = data.kubernetes_service.nginx_ingress.status
}

# output "nginx_ingress_load_balancer_ip" {
#   value = data.kubernetes_service.nginx_ingress.status[0].load_balancer.ingress[0].ip
# }



# resource "aws_route53_record" "nginx_lb" {
#   zone_id = aws_route53_zone.hosted_zone.id
#   name    = aws_route53_zone.hosted_zone.name
#   type    = "A"

#   alias {
#     name                   = data.aws_lb.nginx_ingress_lb[0].dns_name
#     zone_id                = data.aws_lb.nginx_ingress_lb[0].zone_id
#     evaluate_target_health = false
#   }

#   depends_on = [helm_release.nginx_ingress]
# }


# Access (IAM access entries) needs to be (
#   arn:aws:iam::356300141247:role/eks-node-role,
#   arn:aws:iam::356300141247:role/gIDP_admin -> access policy: AmazonEKSClusterAdminPolicy
# )

# provider "http" {}

# data "http" "cert_manager_yaml" {
#   url = "https://github.com/jetstack/cert-manager/releases/download/v1.14.5/cert-manager.yaml"
# }

# locals {
#   cert_manager_documents = [for doc in split("---", data.http.cert_manager_yaml.body) : yamldecode(doc) if doc != ""]
# }

# resource "kubernetes_manifest" "cert_manager" {
#   for_each = { for i, doc in local.cert_manager_documents : i => doc }
#   manifest = each.value
# }

# data "http" "ingress_nginx_yaml" {
#   url = "https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml"
# }

# locals {
#   ingress_nginx_documents = [for doc in split("---", data.http.ingress_nginx_yaml.body) : yamldecode(doc) if doc != ""]
# }

# resource "kubernetes_manifest" "ingress_nginx" {
#   for_each = { for i, doc in local.ingress_nginx_documents : i => doc }
#   manifest = each.value
# }

# resource "null_resource" "namespace_yaml" {
#   provisioner "local-exec" {
#     command = "kubectl replace -f ${path.module}/../yaml/namespace.yaml"
#   }
# }

# provider "http" {}

# data "http" "namespace_yaml" {
#   url = "https://raw.githubusercontent.com/3Edges/3edges-dev/dev/yaml/namespace.yaml"
# }

# locals {
#   namespace_documents = [for doc in split("---", data.http.namespace_yaml.body) : yamldecode(doc) if doc != ""]
# }

# resource "kubernetes_manifest" "namespace" {
#   for_each = { for i, doc in local.namespace_documents : i => doc }
#   manifest = each.value
# }