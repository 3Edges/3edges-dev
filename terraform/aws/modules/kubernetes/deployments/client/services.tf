resource "kubernetes_service" "service_client_dataproxy" {
  metadata {
    name      = "${local.api_name}-proxy"
    namespace = "3edges"
  }

  spec {
    port {
      port = 4044
    }
    selector = {
      app = "${local.api_name}-proxy"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}


resource "kubernetes_service" "service_client_authorization" {
  metadata {
    name      = "${local.api_name}-authz"
    namespace = "3edges"
  }

  spec {
    port {
      port = 5055
    }
    selector = {
      app = "${local.api_name}-authz"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}


resource "kubernetes_service" "service_client_dashboard" {
  metadata {
    name      = "${local.api_name}-dashboard"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3045
    }
    selector = {
      app = "${local.api_name}-dashboard"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}


resource "kubernetes_service" "service_client_idp" {
  metadata {
    name      = "${local.api_name}-idp"
    namespace = "3edges"
  }

  spec {
    port {
      port = 3001
    }
    selector = {
      app = "${local.api_name}-idp"
    }
  }

  depends_on = [var.cert_manager, var.ingress_nginx, var.kubernetes_namespace_namespace]
}


