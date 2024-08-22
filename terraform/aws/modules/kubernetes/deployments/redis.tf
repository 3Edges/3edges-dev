resource "kubernetes_stateful_set" "redis_headless" {
  metadata {
    name      = "redis-headless"
    namespace = "3edges"
  }

  spec {
    service_name = "redis-headless"
    replicas     = 1

    selector {
      match_labels = {
        app = "redis-headless"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis-headless"
        }
      }

      spec {
        container {
          name  = "redis"
          image = "redis:latest"

          port {
            container_port = 6379
          }

          command = [
            "redis-server",
            "/redis-master/redis.conf"
          ]

          volume_mount {
            name       = "config"
            mount_path = "/redis-master"
          }
        }

        volume {
          name = "config"

          config_map {
            name = "redis-config-map"
            items {
              key  = "redis-config"
              path = "redis.conf"
            }
          }
        }
      }
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_config_map" "redis_config_map" {
  metadata {
    name      = "redis-config-map"
    namespace = "3edges"
  }

  data = {
    "redis-config" = <<EOF
      maxmemory 100gb
      maxmemory-policy volatile-lru
    EOF
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "redis_headless" {
  metadata {
    name      = "redis-headless"
    namespace = "3edges"
  }

  spec {
    port {
      port        = 6379
      target_port = 6379
    }

    selector = {
      app = "redis-headless"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}
