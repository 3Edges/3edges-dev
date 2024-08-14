# resource "kubernetes_manifest" "letsencrypt_wildcard" {
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "Certificate"
#     metadata = {
#       name      = "letsencrypt-wildcard"
#       namespace = "3edges"
#     }
#     spec = {
#       dnsNames = [
#         var.hosted_zone,
#         "*.${var.hosted_zone}",
#       ]
#       issuerRef = {
#         kind = "ClusterIssuer"
#         name = "cluster-issuer-abotega"
#       }
#       secretName = "letsencrypt-wildcard-secret"
#     }
#   }
# }