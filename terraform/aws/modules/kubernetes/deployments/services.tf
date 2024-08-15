resource "kubernetes_service" "my_frontend_service" {
  metadata {
    name      = "frontend-srv"
    namespace = "3edges"
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      port = 80
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "my_backend_service" {
  metadata {
    name      = "backend-srv"
    namespace = "3edges"
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port = 3001
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}
