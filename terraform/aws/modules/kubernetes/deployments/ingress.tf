resource "kubernetes_ingress_v1" "my_ingress" {
  metadata {
    name      = "my-ingress"
    namespace = "3edges"

    annotations = {
      "cert-manager.io/cluster-issuer" = "my-cluster-issuer"
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
