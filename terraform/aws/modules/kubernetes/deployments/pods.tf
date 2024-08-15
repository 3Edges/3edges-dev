resource "kubernetes_deployment" "my_frontend_pod" {
  metadata {
    name      = "frontend-pod"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name              = "frontend"
          image             = "abotega/frontend:latest"
          image_pull_policy = "Always"

          env {
            name  = "NODE_ENV"
            value = "development"
          }
        }
      }
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_configuration" {
  metadata {
    name      = "configuration"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "configuration"
      }
    }

    template {
      metadata {
        labels = {
          app  = "configuration"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "configuration"
          image             = "babsy/3edges:configuration"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.configuration_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.configuration_secrets.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.configuration_config, kubernetes_secret.configuration_secrets, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_dataloader_ui" {
  metadata {
    name      = "dataloader-ui"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dataloader-ui"
      }
    }

    template {
      metadata {
        labels = {
          app  = "dataloader-ui"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "dataloader-ui"
          image             = "babsy/3edges:dataloader-ui"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.dataloader_ui_config.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.dataloader_ui_config, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_cluster" {
  metadata {
    name      = "cluster"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cluster"
      }
    }

    template {
      metadata {
        labels = {
          app  = "cluster"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "cluster"
          image             = "babsy/3edges:cluster"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.cluster_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.cluster_secrets.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.cluster_config, kubernetes_secret.cluster_secrets, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_dataloader" {
  metadata {
    name      = "dataloader"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dataloader"
      }
    }

    template {
      metadata {
        labels = {
          app  = "dataloader"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "dataloader"
          image             = "babsy/3edges:dataloader"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.dataloader_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.dataloader_secrets.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.dataloader_config, kubernetes_secret.dataloader_secrets, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_idp" {
  metadata {
    name      = "idp"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "idp"
      }
    }

    template {
      metadata {
        labels = {
          app  = "idp"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "idp"
          image             = "babsy/3edges:idp"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.idp_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.idp_secrets.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.idp_config, kubernetes_secret.idp_secrets, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "deployment_ui" {
  metadata {
    name      = "ui"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ui"
      }
    }

    template {
      metadata {
        labels = {
          app  = "ui"
          prom = "prom-3edges"
        }
      }

      spec {
        container {
          name              = "ui"
          image             = "babsy/3edges:ui"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.ui_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.ui_secrets.metadata[0].name
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_config_map.ui_config, kubernetes_secret.ui_secrets, var.kubernetes_namespace_namespace]
}
