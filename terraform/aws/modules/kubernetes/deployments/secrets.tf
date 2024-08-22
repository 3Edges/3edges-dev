resource "kubernetes_secret" "configuration_secrets" {
  metadata {
    name      = "prim-configuration-secrets"
    namespace = "3edges"
  }

  data = {
    TOKEN_PIPELINE      = var.configuration_config_secret_TOKEN_PIPELINE
    NEO4J_PASSWORD_TEST = var.configuration_config_secret_NEO4J_PASSWORD_TEST
    SESSION_PIPELINE    = var.configuration_config_secret_SESSION_PIPELINE
    DB_PASSWORD         = var.configuration_config_secret_DB_PASSWORD
    PRIM_ADMIN_PASS     = var.configuration_config_secret_PRIM_ADMIN_PASS
    PRIM_JWT_SECRET     = var.configuration_config_secret_PRIM_JWT_SECRET
    OIDC_CLIENT_PWD     = var.configuration_config_secret_OIDC_CLIENT_PWD
    INTERNAL_SECRET     = var.configuration_config_secret_INTERNAL_SECRET
  }


  depends_on = [ var.kubernetes_namespace_namespace ]
}

resource "kubernetes_secret" "dataloader_secrets" {
  metadata {
    name      = "dataloader-secrets"
    namespace = "3edges"
  }

  data = {
    dbPass          = var.dataloader_secret_dbPass
    OIDC_CLIENT_PWD = var.dataloader_secret_OIDC_CLIENT_PWD
  }
  


  depends_on = [ var.kubernetes_namespace_namespace ]
}

resource "kubernetes_secret" "cluster_secrets" {
  metadata {
    name      = "cluster-secrets"
    namespace = "3edges"
  }

  data = {
    OIDC_CLIENT_PWD  = var.cluster_secret_OIDC_CLIENT_PWD
    DB_PASSWORD      = var.cluster_secret_DB_PASSWORD
    PRIVATE_KEY      = var.cluster_secret_PRIVATE_KEY
    CRON_PWD         = var.cluster_secret_CRON_PWD
    SESSION_PIPELINE = var.cluster_secret_SESSION_PIPELINE
    TOKEN_PIPELINE   = var.cluster_secret_TOKEN_PIPELINE
    INTERNAL_SECRET  = var.cluster_secret_INTERNAL_SECRET
  }


  depends_on = [ var.kubernetes_namespace_namespace ]
}

resource "kubernetes_secret" "idp_secrets" {
  metadata {
    name      = "idp-secrets"
    namespace = "3edges"
  }

  data = {
    CLIENT_SECRET_ENC_KEY    = var.idp_secret_CLIENT_SECRET_ENC_KEY
    NiamSvcAcc_Client_secret = var.idp_secret_NiamSvcAcc_Client_secret
    NiamSvcAcc_pwd           = var.idp_secret_NiamSvcAcc_pwd
    DB_PASSWORD              = var.idp_secret_DB_PASSWORD
    CLIENT_PWD_3EDGES        = var.idp_secret_CLIENT_PWD_3EDGES
    INTERNAL_SECRET          = var.idp_secret_INTERNAL_SECRET
  }


  depends_on = [ var.kubernetes_namespace_namespace ]
}

resource "kubernetes_secret" "ui_secrets" {
  metadata {
    name      = "ui-secrets"
    namespace = "3edges"
  }

  data = {
    REACT_APP_OIDC_CLIENT_PWD      = var.ui_secret_REACT_APP_OIDC_CLIENT_PWD
    REACT_APP_INTERNAL_SECRET      = var.ui_secret_REACT_APP_INTERNAL_SECRET
    REACT_APP_CAPTCHA_V2_INVISIBLE = var.ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE
    REACT_APP_CAPTCHA_V2           = var.ui_secret_REACT_APP_CAPTCHA_V2
  }


  depends_on = [ var.kubernetes_namespace_namespace ]
}
