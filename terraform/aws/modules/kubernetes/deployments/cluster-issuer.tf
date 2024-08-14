resource "kubernetes_manifest" "my_cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "my-cluster-issuer"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = "letsencrypt@${var.hosted_zone}"
        privateKeySecretRef = {
          name = "my-cluster-issuer"
        }
        solvers = [
          {
            dns01 = {
              route53 = {
                region       = var.aws_region
                hostedZoneID = var.aws_route53_zone_hosted_zone_id
              }
            },
            selector = {
              dnsZones = [var.hosted_zone, "*.${var.hosted_zone}"]
            }
          }
        ]
      }
    }
  }

  depends_on = [var.cert_manager]
}

resource "kubernetes_manifest" "my_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "my-certificate"
      namespace = "3edges"
    }
    spec = {
      secretName = "certificate-tls"
      issuerRef = {
        name = "my-cluster-issuer"
        kind = "ClusterIssuer"
      }
      dnsNames = [var.hosted_zone, "*.${var.hosted_zone}"]
    }
  }
}