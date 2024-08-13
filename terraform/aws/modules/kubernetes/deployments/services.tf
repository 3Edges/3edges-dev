resource "kubernetes_service" "my_frontend_service" {
  metadata {
    name      = "frontend"
    namespace = "3edges"
  }

  spec {
    selector = {
      app = kubernetes_deployment.my_frontend_pod.metadata[0].name
    }

    port {
      port = 80
    }

    type = "ClusterIP"
  }

  depends_on = [var.k8s_namespace]
}

resource "kubernetes_service" "my_backend_service" {
  metadata {
    name      = "backend"
    namespace = "3edges"
  }

  spec {
    selector = {
      app = kubernetes_deployment.my_backend_pod.metadata[0].name
    }

    port {
      port = 3001
    }

    type = "ClusterIP"
  }

  depends_on = [var.k8s_namespace]
}
