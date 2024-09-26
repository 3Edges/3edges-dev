resource "kubernetes_secret" "default_secret" {
  metadata {
    name      = "prim-${local.api_name}-secret"
    namespace = "3edges"
  }

  data = {
    ENC_KEY                   = random_string.enc_key.result
    AUTHZ_PWD                 = random_string.authz_pwd.result
    PROXY_PWD                 = random_string.proxy_pwd.result
    NiamSvcAcct_id            = "sa_${local.api_name}"
    NiamSvcAcct_name          = "sa_${local.api_name}"
    NiamSvcAcct_username      = "sa_${local.api_name}"
    NiamSvcAcct_secret        = random_string.NiamSvcAcct_secret.result
    NiamSvcAcctClient_id      = "sac_${local.api_name}"
    NiamSvcAcctClient_name    = "sac_${local.api_name}"
    NiamSvcAcctClient_secret  = random_string.NiamSvcAcctClient_secret.result
    CLIENT_PWD_3EDGES         = random_string.client_pwd_three_edges.result   
    OIDC_CLIENT_PWD           = random_string.oidc_client_pwd.result          
    VC_CLIENT_SECRET          = ""
    INTERNAL_SECRET           =  var.shared_secret_INTERNAL_SECRET
    PRIM_JWT_SECRET           = random_string.prim_jwt_secret.result
    DB_PASSWORD               = ""
    REACT_APP_OIDC_CLIENT_PWD = random_string.react_app_oidc_client_pwd.result

  }


  depends_on = [var.kubernetes_namespace_namespace]
}

