# resource "kubernetes_service" "my_service" {
#   metadata {
#     name      = "my-service"
#     namespace = "3edges"
#   }

#   spec {
#     selector = {
#       app = kubernetes_pod.my_pod.metadata[0].name
#     }

#     port {
#       port        = 80
#       target_port = 80
#     }

#     type = "ClusterIP"
#   }

#   depends_on = [var.k8s_namespace]
# }
