terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.31.0"
    }
  }
}

resource "kubernetes_secret" "aws_credentials" {
  metadata {
    name      = "aws-credentials"
    namespace = "cert-manager"
  }

  data = {
    aws_access_key_id     = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
  }
}


resource "kubernetes_manifest" "cert_manager_cluster_issuer" {
  count = var.exclude_cluster_issuer ? 0 : 1

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "cert-manager-cluster-issuer"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = "letsencrypt@${var.hosted_zone}"
        privateKeySecretRef = {
          name = "cert-manager-cluster-issuer"
        }
        solvers = [
          {
            dns01 = {
              route53 = {
                region       = "${var.aws_region}"
                hostedZoneID = "${var.aws_route53_zone_hosted_zone_id}"
                accessKeyIDSecretRef = {
                  name = kubernetes_secret.aws_credentials.metadata[0].name
                  key  = "aws_access_key_id"
                }
                secretAccessKeySecretRef = {
                  name = kubernetes_secret.aws_credentials.metadata[0].name
                  key  = "aws_secret_access_key"
                }
              }
            },
            selector = {
              dnsZones = ["${var.hosted_zone}", "*.${var.hosted_zone}"]
            }
          }
        ]
      }
    }
  }
depends_on = [
  var.aws_eks_cluster_auth_endpoint, 
  var.cert_manager, 
  var.ingress_nginx, 
  var.kubernetes_namespace_namespace
  

  ]
  
}

resource "kubernetes_manifest" "letsencrypt_wildcard" {
  count = var.exclude_certificate ? 0 : 1
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      name      = "letsencrypt-wildcard"
      namespace = "3edges"
    }

    spec = {
      issuerRef = {
        kind = "ClusterIssuer"
        name = "cert-manager-cluster-issuer"
      }
      secretName = "letsencrypt-wildcard-secret"
      dnsNames   = ["${var.hosted_zone}", "*.${var.hosted_zone}"]
    }
  }
  depends_on = [kubernetes_manifest.cert_manager_cluster_issuer]
}


module "client" {
  count = var.manual_api_deployment ? 1 : 0   # Manual API deployment enabled or disabled
  source                                               = "./client"
  cert_manager                                         = var.cert_manager
  ingress_nginx                                        = var.ingress_nginx
  hosted_zone                                          = var.hosted_zone
  aws_region                                           = var.aws_region
  aws_access_key_id                                    = var.aws_access_key_id
  aws_secret_access_key                                = var.aws_secret_access_key
  aws_route53_zone_hosted_zone_id                      = var.aws_route53_zone_hosted_zone_id
  kubernetes_namespace_namespace                       = var.kubernetes_namespace_namespace
  aws_eks_cluster_auth_endpoint                        = var.aws_eks_cluster_auth_endpoint
  exclude_cluster_issuer                               = var.exclude_cluster_issuer
  exclude_certificate                                  = var.exclude_certificate
  shared_config_PRIM_ADMIN_EMAIL                       = var.shared_config_PRIM_ADMIN_EMAIL
  shared_secret_INTERNAL_SECRET                        = var.shared_secret_INTERNAL_SECRET
  api_name = var.api_name
  PROM_METRICS_PREFIX = var.PROM_METRICS_PREFIX

  providers = {
    kubernetes = kubernetes
  }
}

# Use the output from the client module
output "api_name_from_client" {
  value = var.manual_api_deployment ? module.client[0].api_name : "" 
}

output "PROM_METRICS_PREFIX_from_client" {
  value = var.manual_api_deployment ? module.client[0].PROM_METRICS_PREFIX : ""  
}

