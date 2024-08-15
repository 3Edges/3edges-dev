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

  depends_on = [
    # var.cert_manager,
  var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_deployment" "my_backend_pod" {
  metadata {
    name      = "backend-pod"
    namespace = "3edges"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name              = "backend"
          image             = "abotega/backend:latest"
          image_pull_policy = "Always"

          env {
            name  = "NODE_ENV"
            value = "development"
          }

          env {
            name  = "PORT"
            value = "3001"
          }

          env {
            name  = "REDIS_HOST"
            value = "redis-headless"
          }
        }
      }
    }
  }

  depends_on = [
    # var.cert_manager,
  var.ingress_nginx, var.kubernetes_namespace_namespace]
}
