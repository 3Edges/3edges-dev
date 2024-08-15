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
                region       = var.aws_region
                hostedZoneID = var.aws_route53_zone_hosted_zone_id
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
              dnsZones = ["*.${var.hosted_zone}"]
            }
          }
        ]
      }
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_manifest" "letsencrypt_wildcard" {
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
      dnsNames   = ["*.${var.hosted_zone}"]
    }
  }

  depends_on = [kubernetes_manifest.cert_manager_cluster_issuer]
}