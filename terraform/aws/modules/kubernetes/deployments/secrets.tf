resource "kubernetes_secret" "configuration_secrets" {
  metadata {
    name      = "prim-configuration-secrets"
    namespace = "3edges"
  }

  data = {
    NEO4J_PASSWORD_TEST = "your-base64-encoded-value"
    NEO4J_PASSWORD      = "your-base64-encoded-value"
    PRIM_ADMIN_PASS     = "your-base64-encoded-value"
    PRIM_JWT_SECRET     = "your-base64-encoded-value"
    OIDC_CLIENT_PWD     = "your-base64-encoded-value"
  }
}

resource "kubernetes_secret" "dataloader_secrets" {
  metadata {
    name      = "dataloader-secrets"
    namespace = "3edges"
  }

  data = {
    dbPass          = "your-base64-encoded-value"
    OIDC_CLIENT_PWD = "your-base64-encoded-value"
  }
}

resource "kubernetes_secret" "cluster_secrets" {
  metadata {
    name      = "cluster-secrets"
    namespace = "3edges"
  }

  data = {
    OIDC_CLIENT_PWD  = "your-base64-encoded-value"
    DB_PASSWORD      = "your-base64-encoded-value"
    PRIVATE_KEY      = "your-base64-encoded-value"
    CRON_PWD         = "your-base64-encoded-value"
    SESSION_PIPELINE = "your-base64-encoded-value"
    TOKEN_PIPELINE   = "your-base64-encoded-value"
    INTERNAL_SECRET  = "your-base64-encoded-value"
  }
}

resource "kubernetes_secret" "idp_secrets" {
  metadata {
    name      = "idp-secrets"
    namespace = "3edges"
  }

  data = {
    CLIENT_SECRET_ENC_KEY    = "your-base64-encoded-value"
    NiamSvcAcc_Client_secret = "your-base64-encoded-value"
    NiamSvcAcc_pwd           = "your-base64-encoded-value"
    DB_PASSWORD              = "your-base64-encoded-value"
    CLIENT_PWD_3EDGES        = "your-base64-encoded-value"
  }
}

resource "kubernetes_secret" "ui_secrets" {
  metadata {
    name      = "ui-secrets"
    namespace = "3edges"
  }

  data = {
    REACT_APP_OIDC_CLIENT_PWD = "your-base64-encoded-value"
    REACT_APP_INTERNAL_SECRET = "your-base64-encoded-value"
  }
}
