resource "kubernetes_ingress_v1" "my_ingress" {
  metadata {
    name      = "abotega-ingress"
    namespace = "3edges"

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" : "true"
      "alb.ingress.kubernetes.io/scheme" : "internet-facing"
      "alb.ingress.kubernetes.io/certificate-arn" : var.certificate_arn
      "alb.ingress.kubernetes.io/ssl-redirect" : "443"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["abotega.com", "*.abotega.com"]
      secret_name = "letsencrypt-wildcard-secret"
    }

    rule {
      host = "abotega.com"
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
      host = "cluster.abotega.com"
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
}
