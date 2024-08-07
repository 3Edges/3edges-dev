
provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_auth.token
  }
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

resource "helm_release" "cert_manager" {
  name             = "cert_manager_name"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.5"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}


# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress"
#   namespace  = "kube-system"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   version    = "4.0.6"

#   values = [
#     <<EOF
# controller:
#   service:
#     type: LoadBalancer
# EOF
#   ]

#   depends_on = [aws_eks_cluster.eks_cluster]
# }

# data "kubernetes_service" "nginx_ingress" {
#   metadata {
#     name      = "nginx-ingress-controller"
#     namespace = "kube-system"
#   }
# }

# output "nginx_ingress_load_balancer_hostname" {
#   value = data.kubernetes_service.nginx_ingress.status[0].load_balancer.ingress[0].hostname
# }

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

# resource "null_resource" "apply_cert_manager" {
#   provisioner "local-exec" {
#     command = "bash ${path.module}/../yaml/external_yaml.sh 'https://github.com/jetstack/cert-manager/releases/download/v1.14.5/cert-manager.yaml'"
#   }
# }
