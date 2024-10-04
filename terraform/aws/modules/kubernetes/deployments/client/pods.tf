resource "kubernetes_deployment" "deployment_dataproxy" {
  metadata {
    name      = "${local.api_name}-proxy"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${local.api_name}-proxy"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.api_name}-proxy"
        }
      }

      spec {
        container {
          name              = "${local.api_name}-proxy"
          image             = "abotega/prim-dataproxy:hub"
          image_pull_policy = "Always"

          volume_mount {
            name       = "${local.api_name}-config-volume"
            mount_path = "/app/etc/config" # Mount path inside the container
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.json_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.default_secret.metadata[0].name
            }
          }
        }

        volume {
          name = "${local.api_name}-config-volume"

          config_map {
            name = kubernetes_config_map.json_config.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [var.kubernetes_namespace_namespace]
}


resource "kubernetes_deployment" "deployment_authorization" {
  metadata {
    name      = "${local.api_name}-authz"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${local.api_name}-authz"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.api_name}-authz"
        }
      }

      spec {
        container {
          name              = "${local.api_name}-authz"
          image             = "abotega/prim-authorization:hub"
          image_pull_policy = "Always"

          volume_mount {
            name       = "${local.api_name}-config-volume"
            mount_path = "/app/etc/config" # Mount path inside the container
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.json_config.metadata[0].name
            }
          }


          env_from {
            secret_ref {
              name = kubernetes_secret.default_secret.metadata[0].name
            }
          }
        }

        volume {
          name = "${local.api_name}-config-volume"

          config_map {
            name = kubernetes_config_map.json_config.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [var.kubernetes_namespace_namespace]
}


resource "kubernetes_deployment" "deployment_dashboard" {
  metadata {
    name      = "${local.api_name}-dashboard"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${local.api_name}-dashboard"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.api_name}-dashboard"
        }
      }

      spec {
        container {
          name              = "${local.api_name}-dashboard"
          image             = "abotega/prim-client-ui:hub"
          image_pull_policy = "Always"

          volume_mount {
            name       = "${local.api_name}-config-volume"
            mount_path = "/app/etc/config" # Mount path inside the container
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.json_config.metadata[0].name
            }
          }


          env_from {
            secret_ref {
              name = kubernetes_secret.default_secret.metadata[0].name
            }
          }
        }

        volume {
          name = "${local.api_name}-config-volume"

          config_map {
            name = kubernetes_config_map.json_config.metadata[0].name
          }
        }

      }
    }
  }

  depends_on = [var.kubernetes_namespace_namespace]
}


resource "kubernetes_deployment" "deployment_client_idp" {
  metadata {
    name      = "${local.api_name}-idp"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${local.api_name}-idp"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.api_name}-idp"
        }
      }

      spec {
        container {
          name              = "${local.api_name}-idp"
          image             = "abotega/prim-idp:hub"
          image_pull_policy = "Always"

          volume_mount {
            name       = "${local.api_name}-config-volume"
            mount_path = "/app/etc/config" # Mount path inside the container
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.json_config.metadata[0].name
            }
          }


          env_from {
            secret_ref {
              name = kubernetes_secret.default_secret.metadata[0].name
            }
          }
        }

        volume {
          name = "${local.api_name}-config-volume"

          config_map {
            name = kubernetes_config_map.json_config.metadata[0].name
          }
        }

      }
    }
  }

  depends_on = [var.kubernetes_namespace_namespace]
}
