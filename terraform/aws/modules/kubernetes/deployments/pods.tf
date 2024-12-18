resource "kubernetes_deployment" "deployment_configuration" {
  metadata {
    name      = "configuration"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "configuration"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name              = "configuration"
          image             = "indykite/3edges-configuration:latest"
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

  depends_on = [kubernetes_config_map.configuration_config, kubernetes_secret.configuration_secrets, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}

resource "kubernetes_deployment" "deployment_dataloader_ui" {
  metadata {
    name      = "dataloader-ui"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "dataloader-ui"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name              = "dataloader-ui"
          image = "indykite/3edges-webloader:latest"
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

  depends_on = [kubernetes_config_map.dataloader_ui_config, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}

resource "kubernetes_deployment" "deployment_dataloader" {
  metadata {
    name      = "dataloader"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "dataloader"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name              = "dataloader"
          image = "indykite/3edges-dataloader:latest"
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

  depends_on = [kubernetes_config_map.dataloader_config, kubernetes_secret.dataloader_secrets, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}

resource "kubernetes_deployment" "deployment_cluster" {
  metadata {
    name      = "cluster"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "cluster"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name              = "cluster"
          image = "indykite/3edges-cluster:latest"
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

  depends_on = [kubernetes_config_map.cluster_config, kubernetes_secret.cluster_secrets, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}


resource "kubernetes_deployment" "deployment_idp" {
  metadata {
    name      = "idp"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "idp"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name              = "idp"
          image = "indykite/3edges-idp:latest"
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

  depends_on = [kubernetes_config_map.idp_config, kubernetes_secret.idp_secrets, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}

resource "kubernetes_deployment" "deployment_ui" {
  metadata {
    name      = "ui"
    namespace = "3edges"
    labels = {
      type = "3edges_control_plane"
     }
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
          app = "ui"
          type = "3edges_control_plane"
        }
      }

      spec {
        container {
          name = "ui"
          image             = "indykite/3edges-ui:latest"
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

  depends_on = [kubernetes_config_map.ui_config, kubernetes_secret.ui_secrets, var.kubernetes_namespace_namespace, kubernetes_stateful_set.redis_headless]
}
