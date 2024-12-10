resource "kubernetes_deployment" "deployment_dataproxy" {
  metadata {
    name      = "${local.api_name}-proxy"
    namespace = "3edges"
    labels = {
      type = "3edges_client_api"
     }
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
          image             = "indykite/3edges-dataproxy:latest"
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
    labels = {
      type = "3edges_client_api"
     }
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
          image             = "indykite/3edges-authorization:latest"
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

#CSP Engine Authz
resource "kubernetes_deployment" "deployment_authorization_csp" {
  metadata {
    name      = "${local.api_name}-authz-csp"
    namespace = "3edges"
    labels = {
      type = "3edges_client_api"
     }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${local.api_name}-authz-csp"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.api_name}-authz-csp"
        }
      }

      spec {
        container {
          name              = "${local.api_name}-authz-csp"
          image             = "indykite/3edges-authorization-csp:latest"
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
    labels = {
      type = "3edges_client_api"
     }
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
          image             = "indykite/3edges-dashboard:latest"
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
    labels = {
      type = "3edges_client_api"
     }
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
          image = "indykite/3edges-idp:latest"
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
