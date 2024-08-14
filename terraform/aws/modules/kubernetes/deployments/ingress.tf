resource "kubernetes_ingress_v1" "my_ingress" {
  metadata {
    name      = "my-ingress"
    namespace = "3edges"

    annotations = {
      # "alb.ingress.kubernetes.io/scheme" : "internet-facing"
      # "alb.ingress.kubernetes.io/certificate-arn" : var.certificate_arn
      # "alb.ingress.kubernetes.io/certificate-arn" : "arn:aws:acm:ca-west-1:356300141247:certificate/a41ecddb-d3e4-4df7-a5db-0fe40ba5e187"
      # "alb.ingress.kubernetes.io/ssl-redirect" : "443"
      # "nginx.ingress.kubernetes.io/ssl-redirect" : "true"
      "cert-manager.io/cluster-issuer"           = "my-cluster-issuer"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = [var.hosted_zone, "*.${var.hosted_zone}"]
      secret_name = "certificate-tls"
    }

    rule {
      host = var.hosted_zone
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.my_frontend_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    rule {
      host = "cluster.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.my_backend_service.metadata[0].name
              port {
                number = 3001
              }
            }
          }
        }
      }
    }
  }

  depends_on = [var.k8s_namespace]
  # depends_on = [var.k8s_namespace, var.certificate_arn]
}
