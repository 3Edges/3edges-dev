resource "kubernetes_ingress_v1" "three_edges_client_ingress" {
  metadata {
    name      = "${local.api_name}-ingress"
    namespace = "3edges"

    annotations = {
      "cert-manager.io/cluster-issuer" = "cert-manager-cluster-issuer"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = [var.hosted_zone, "*.${var.hosted_zone}"]
      secret_name = "letsencrypt-wildcard-secret"
    }

    rule {
      host = "${local.api_name}.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "${local.api_name}-proxy"
              port {
                number = 4044
              }
            }
          }
        }
      }
    }

    rule {
      host = "${local.api_name}-authz.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "${local.api_name}-authz"
              port {
                number = 5055
              }
            }
          }
        }
      }
    }

    rule {
      host = "${local.api_name}-dashboard.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "${local.api_name}-dashboard"
              port {
                number = 3045
              }
            }
          }
        }
      }
    }

    rule {
      host = "${local.api_name}-idp.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "${local.api_name}-idp"
              port {
                number = 3001
              }
            }
          }
        }
      }
    }

  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}
