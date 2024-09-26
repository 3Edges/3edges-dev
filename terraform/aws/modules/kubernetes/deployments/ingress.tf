resource "kubernetes_ingress_v1" "three_edges_ingress" {
  metadata {
    name      = "three-edges-ingress"
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
      host = "frontend.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "ui"
              port {
                number = 3005
              }
            }
          }
        }

        path {
          path      = "/graphql"
          path_type = "Exact"
          backend {
            service {
              name = "configuration"
              port {
                number = 4005
              }
            }
          }
        }
      }
    }

    rule {
      host = "dataloader.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "dataloader"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }

    rule {
      host = "idp.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "idp"
              port {
                number = 3007
              }
            }
          }
        }
      }
    }

    rule {
      host = "webloader.${var.hosted_zone}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "dataloader-ui"
              port {
                number = 3002
              }
            }
          }
        }
      }
    }

    rule {
      host = var.hosted_zone
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "cluster"
              port {
                number = 3333

              }
            }
          }
        }
      }
    }

  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}
