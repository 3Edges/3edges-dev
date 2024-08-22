resource "kubernetes_secret" "configuration_secrets" {
  metadata {
    name      = "prim-configuration-secrets"
    namespace = "3edges"
  }

  data = {
    TOKEN_PIPELINE      = "your-pwd-value"
    NEO4J_PASSWORD_TEST = "your-pwd-value"
    SESSION_PIPELINE    = "your-pwd-value"
    DB_PASSWORD         = "your-pwd-value"
    PRIM_ADMIN_PASS     = "your-pwd-value"
    PRIM_JWT_SECRET     = "your-pwd-value"
    OIDC_CLIENT_PWD     = "your-pwd-value"
    INTERNAL_SECRET     = "your-pwd-value"
  }
}

# resource "kubernetes_secret" "dataloader_secrets" {
#   metadata {
#     name      = "dataloader-secrets"
#     namespace = "3edges"
#   }

#   data = {
#     dbPass          = "your-pwd-value"
#     OIDC_CLIENT_PWD = "your-pwd-value"
#   }
# }

# resource "kubernetes_secret" "cluster_secrets" {
#   metadata {
#     name      = "cluster-secrets"
#     namespace = "3edges"
#   }

#   data = {
#     OIDC_CLIENT_PWD  = "your-pwd-value"
#     DB_PASSWORD      = "your-pwd-value"
#     PRIVATE_KEY      = "your-pwd-value"
#     CRON_PWD         = "your-pwd-value"
#     SESSION_PIPELINE = "your-pwd-value"
#     TOKEN_PIPELINE   = "your-pwd-value"
#     INTERNAL_SECRET  = "your-pwd-value"
#   }
# }

# resource "kubernetes_secret" "idp_secrets" {
#   metadata {
#     name      = "idp-secrets"
#     namespace = "3edges"
#   }

#   data = {
#     CLIENT_SECRET_ENC_KEY    = "your-pwd-value"
#     NiamSvcAcc_Client_secret = "your-pwd-value"
#     NiamSvcAcc_pwd           = "your-pwd-value"
#     DB_PASSWORD              = "your-pwd-value"
#     CLIENT_PWD_3EDGES        = "your-pwd-value"
#     INTERNAL_SECRET          = "your-pwd-value"
#   }
# }

# resource "kubernetes_secret" "ui_secrets" {
#   metadata {
#     name      = "ui-secrets"
#     namespace = "3edges"
#   }

#   data = {
#     REACT_APP_OIDC_CLIENT_PWD      = "your-pwd-value"
#     REACT_APP_INTERNAL_SECRET      = "your-pwd-value"
#     REACT_APP_CAPTCHA_V2_INVISIBLE = "your-pwd-value"
#     REACT_APP_CAPTCHA_V2           = "your-pwd-value"
#   }
# }
