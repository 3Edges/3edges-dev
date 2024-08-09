# resource "kubernetes_pod" "my_pod" {

#   metadata {
#     name      = "my-pod"
#     namespace = "3edges"
#   }

#   spec {
#     container {
#       image = "nginx:latest"
#       name  = "nginx"

#       port {
#         container_port = 80
#       }
#     }
#   }

#   depends_on = [var.k8s_namespace]
# }
