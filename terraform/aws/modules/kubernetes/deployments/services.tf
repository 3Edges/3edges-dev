resource "kubernetes_service" "my_frontend_service" {
  metadata {
    name      = "frontend"
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

resource "kubernetes_service" "service_3edges_configuration" {
  metadata {
    name      = "configuration"
    namespace = "3edges"
  }

  spec {
    port {
      port = 4005
    }
    selector = {
      app = "configuration"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "service_3edges_cluster" {
  metadata {
    name      = "cluster"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3333
    }
    selector = {
      app = "cluster"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "service_3edges_dataloader_ui" {
  metadata {
    name      = "dataloader-ui"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3002
    }
    selector = {
      app = "dataloader-ui"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "service_3edges_dataloader" {
  metadata {
    name      = "dataloader"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3000
    }
    selector = {
      app = "dataloader"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "service_3edges_idp" {
  metadata {
    name      = "idp"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3001
    }
    selector = {
      app = "idp"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}

resource "kubernetes_service" "service_3edges_ui" {
  metadata {
    name      = "ui"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3005
    }
    selector = {
      app = "ui"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}
