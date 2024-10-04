resource "kubernetes_config_map" "configuration_config" {
  metadata {
    name      = "configuration-config"
    namespace = "3edges"
  }

  data = {
    NODE_ENV                                      = var.configuration_config_NODE_ENV
    SERVER_PORT                                   = var.configuration_config_SERVER_PORT
    ENABLE_INTROSPECTION                          = var.configuration_config_ENABLE_INTROSPECTION
    ENABLE_PLAYGROUND                             = var.configuration_config_ENABLE_PLAYGROUND
    REACT_APP_OTP_VALIDITY                        = var.configuration_config_REACT_APP_OTP_VALIDITY
    SEND_EMAIL_FROM                               = var.shared_config_SEND_EMAIL_FROM
    SEND_EMAIL_FROM_NAME                          = var.shared_config_SEND_EMAIL_FROM_NAME
    SEND_EMAIL_URL                                = var.configuration_config_SEND_EMAIL_URL
    NEO4J_POOL_SIZE                               = var.configuration_config_NEO4J_POOL_SIZE
    NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS       = var.configuration_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
    NEO4J_MAX_CONNECTION_LIFETIME                 = var.configuration_config_NEO4J_MAX_CONNECTION_LIFETIME
    NEO4J_CONNECTION_TIMEOUT                      = var.configuration_config_NEO4J_CONNECTION_TIMEOUT
    RESET_ADMIN_USER                              = var.configuration_config_RESET_ADMIN_USER
    PRIM_ADMIN_EMAIL                              = var.shared_config_PRIM_ADMIN_EMAIL
    NEO4J_URL_TEST                                = var.configuration_config_NEO4J_URL_TEST
    PRIM_CONFIG_NEO4J_DB_TEST                     = var.configuration_config_PRIM_CONFIG_NEO4J_DB_TEST
    PRIM_SERVER_HTTP_CORS_ORIGIN                  = var.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN
    PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN          = var.configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN
    DB_TYPE                                       = var.three_edges_DB_TYPE
    DB_VERSION                                    = var.three_edges_DB_VERSION
    DB_HOST                                       = var.three_edges_DB_HOST
    DB_NAME                                       = var.three_edges_DB_NAME
    DB_USER                                       = var.three_edges_DB_USER
    CLUSTER_URL                                   = var.configuration_config_CLUSTER_URL
    COOKIE_NNCE                                   = var.configuration_config_COOKIE_NNCE
    COOKIE_PRIMSCOOKIE                            = var.configuration_config_COOKIE_PRIMSCOOKIE
    COOKIE_PKEY                                   = var.configuration_config_COOKIE_PKEY
    REDIS_HOST                                    = var.configuration_config_REDIS_HOST
    REDIS_PORT                                    = var.configuration_config_REDIS_PORT
    REDIS_TIMEOUT_GET_APISERVER_STATUS            = var.configuration_config_REDIS_TIMEOUT_GET_APISERVER_STATUS
    LOCALHOST_PROXY_DASHBOARD_URL                 = var.configuration_config_LOCALHOST_PROXY_DASHBOARD_URL
    LOCALHOST_PROXY_IDP_URL                       = var.configuration_config_LOCALHOST_PROXY_IDP_URL
    LOCALHOST_PROXY_AUTHORIZATION_URL             = var.configuration_config_LOCALHOST_PROXY_AUTHORIZATION_URL
    AUTHZ_POD_PORT                                = var.configuration_config_AUTHZ_POD_PORT
    DASHBOARD_POD_PORT                            = var.configuration_config_DASHBOARD_POD_PORT
    IDP_POD_PORT                                  = var.configuration_config_IDP_POD_PORT
    PROXY_POD_PORT                                = var.configuration_config_PROXY_POD_PORT
    DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = var.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY
    MAX_SHUTDOWN                                  = var.configuration_config_MAX_SHUTDOWN
    MAX_REDEPLOY                                  = var.configuration_config_MAX_REDEPLOY
    SEND_EMAIL_SERVER                             = var.configuration_config_SEND_EMAIL_SERVER
    COST_LIMIT_ENABLED                            = var.configuration_config_COST_LIMIT_ENABLED
    COST_LIMIT_MAXCOST                            = var.configuration_config_COST_LIMIT_MAXCOST
    COST_LIMIT_OBJECTCOST                         = var.configuration_config_COST_LIMIT_OBJECTCOST
    COST_LIMIT_SCALARCOST                         = var.configuration_config_COST_LIMIT_SCALARCOST
    COST_LIMIT_DEPTHCOSTFACTOR                    = var.configuration_config_COST_LIMIT_DEPTHCOSTFACTOR
    COST_LIMIT_IGNOREINTROSPECTION                = var.configuration_config_COST_LIMIT_IGNOREINTROSPECTION
    COST_LIMIT_N                                  = var.configuration_config_COST_LIMIT_N
    MAX_ALIASES_ENABLED                           = var.configuration_config_MAX_ALIASES_ENABLED
    MAX_ALIASES_N                                 = var.configuration_config_MAX_ALIASES_N
    MAX_DIRECTIVES_N                              = var.configuration_config_MAX_DIRECTIVES_N
    MAX_DEPTH_N                                   = var.configuration_config_MAX_DEPTH_N
    MAX_TOKENS_N                                  = var.configuration_config_MAX_TOKENS_N
    PRIM_SERVER_HTTP_CORS_ORIGIN_IDP              = var.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP
    MAX_CHARACTERS_N                              = var.configuration_config_MAX_CHARACTERS_N
    PROCESS_TIMEOUT_N                             = var.configuration_config_PROCESS_TIMEOUT_N
    UI_PROCESS_TIMEOUT_N                          = var.configuration_config_UI_PROCESS_TIMEOUT_N
    DB_RECORDS_BATCH_SIZE                         = var.configuration_config_DB_RECORDS_BATCH_SIZE
    QUERY_COMPLEXITY_LIMIT                        = var.configuration_config_QUERY_COMPLEXITY_LIMIT
    DEFAULT_CONTENT_SECURITY_POLICY               = var.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY
    UI_URL                                        = var.configuration_config_UI_URL
    OIDC_URL                                      = var.configuration_config_OIDC_URL
    OIDC_CLIENT_ID                                = var.configuration_config_OIDC_CLIENT_ID
  }

  depends_on = [var.kubernetes_namespace_namespace]

}

resource "kubernetes_config_map" "dataloader_ui_config" {
  metadata {
    name      = "dataloader-ui-config"
    namespace = "3edges"
  }

  data = {
    NODE_ENV                           = var.dataloader_ui_config_NODE_ENV
    PORT                               = var.dataloader_ui_config_PORT
    REACT_APP_DATALOADER_URL           = var.dataloader_ui_config_REACT_APP_DATALOADER_URL
    REACT_APP_UI_URL_3EDGES            = var.dataloader_ui_config_REACT_APP_UI_URL_3EDGES
    REACT_APP_ACCESS_TOKEN_COOKIE_NAME = var.dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
    REACT_APP_NONCE_COOKIE_NAME        = var.dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME
    REACT_APP_PKEY_COOKIE_NAME         = var.dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME
    REACT_APP_ID_TOKEN_COOKIE_NAME     = var.dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
    REACT_APP_OIDC_CLIENT_ID           = var.dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID
    REACT_APP_OIDC_URL                 = var.dataloader_ui_config_REACT_APP_OIDC_URL
    REACT_APP_JWKS_URI                 = var.dataloader_ui_config_REACT_APP_JWKS_URI
    REACT_APP_DOCUMENTATION_URL        = var.dataloader_ui_config_REACT_APP_DOCUMENTATION_URL
  }

  depends_on = [var.kubernetes_namespace_namespace]
}

resource "kubernetes_config_map" "dataloader_config" {
  metadata {
    name      = "dataloader-config"
    namespace = "3edges"
  }

  data = {
    NODE_ENV                                = var.dataloader_config_NODE_ENV
    CORS_ORIGIN                             = var.dataloader_config_CORS_ORIGIN
    PORT                                    = var.dataloader_config_PORT
    NEO4J_POOL_SIZE                         = var.dataloader_config_NEO4J_POOL_SIZE
    NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS = var.dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
    NEO4J_MAX_CONNECTION_LIFETIME           = var.dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME
    NEO4J_CONNECTION_TIMEOUT                = var.dataloader_config_NEO4J_CONNECTION_TIMEOUT
    dbName                                  = var.three_edges_DB_NAME
    dbUser                                  = var.three_edges_DB_USER
    dbHost                                  = var.three_edges_DB_HOST
    OIDC_URL                                = var.dataloader_config_OIDC_URL
    OIDC_CLIENT_ID                          = var.dataloader_config_OIDC_CLIENT_ID
    CONFIGURATION_URL                       = var.dataloader_config_CONFIGURATION_URL
  }



  depends_on = [var.kubernetes_namespace_namespace]
}

resource "kubernetes_config_map" "cluster_config" {
  metadata {
    name      = "cluster-config"
    namespace = "3edges"
  }
  data = {
    NODE_ENV              = var.cluster_config_NODE_ENV
    PORT                  = var.cluster_config_PORT
    UI_URL                = var.cluster_config_UI_URL
    CLIENT_EMAIL          = var.cluster_config_CLIENT_EMAIL
    OIDC_URL              = var.cluster_config_OIDC_URL
    OIDC_CLIENT_ID        = var.cluster_config_OIDC_CLIENT_ID
    config_CLUSTER        = var.cluster_config_config_CLUSTER
    config_LOCATION       = var.cluster_config_config_LOCATION
    NGINX_LB              = var.cluster_config_NGINX_LB
    DB_TYPE               = var.three_edges_DB_TYPE
    DB_VERSION            = var.three_edges_DB_VERSION
    DB_HOST               = var.three_edges_DB_HOST
    DB_NAME               = var.three_edges_DB_NAME
    DB_USER               = var.three_edges_DB_USER
    CLUSTER_URL           = var.cluster_config_CLUSTER_URL
    SEND_EMAIL_URL        = var.cluster_config_SEND_EMAIL_URL
    SEND_EMAIL_SERVER     = var.cluster_config_SEND_EMAIL_SERVER
    SEND_EMAIL_FROM       = var.shared_config_SEND_EMAIL_FROM
    SEND_EMAIL_FROM_NAME  = var.shared_config_SEND_EMAIL_FROM_NAME
    PRIM_ADMIN_EMAIL      = var.shared_config_PRIM_ADMIN_EMAIL
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
    CLUSTER               = var.eks_cluster
    AWS_DEFAULT_REGION    = var.aws_region
    API_NAME              = local.api_name
    hostedZoneID          = var.aws_route53_zone_hosted_zone_id

  }


  depends_on = [var.kubernetes_namespace_namespace]
}



resource "kubernetes_config_map" "idp_config" {
  metadata {
    name      = "idp-config"
    namespace = "3edges"
  }

  data = {
    NODE_ENV                              = var.idp_config_NODE_ENV
    OIDC_PORT                             = var.idp_config_OIDC_PORT
    SERVER_HTTP_CORS_ORIGIN               = var.idp_config_SERVER_HTTP_CORS_ORIGIN
    SERVER_HTTP_STRICT_TRANSPORT_SECURITY = var.idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY
    SERVER_HTTP_X_FRAME_OPTIONS           = var.idp_config_SERVER_HTTP_X_FRAME_OPTIONS
    PRIM_ADMIN_EMAIL                      = var.shared_config_PRIM_ADMIN_EMAIL
    CHECK_VERIFIED                        = var.idp_config_CHECK_VERIFIED
    NAMING_PROPERTY                       = var.idp_config_NAMING_PROPERTY
    SUBJECT_TYPE                          = var.idp_config_SUBJECT_TYPE
    AUTHN_QUERY                           = var.idp_config_AUTHN_QUERY
    AUTHN_QUERY_VERIFIED                  = var.idp_config_AUTHN_QUERY_VERIFIED
    SOCIAL_URL                            = var.idp_config_SOCIAL_URL
    CLAIMS_ARRAY                          = var.idp_config_CLAIMS_ARRAY
    OIDC_ACCESS_TOKEN_EXPIRE              = var.idp_config_OIDC_ACCESS_TOKEN_EXPIRE
    CONTENT_SECURITY_POLICY               = var.idp_config_CONTENT_SECURITY_POLICY
    ALLOW_HTTP_REDIRECTS                  = var.idp_config_ALLOW_HTTP_REDIRECTS
    PRIM_UI_URL                           = var.idp_config_PRIM_UI_URL
    OIDC_AUTHORIZE_ENDPOINT               = var.idp_config_OIDC_AUTHORIZE_ENDPOINT
    OIDC_TOKEN_ENDPOINT                   = var.idp_config_OIDC_TOKEN_ENDPOINT
    OIDC_TOKEN_INTROSPECTION_ENDPOINT     = var.idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT
    OIDC_ME_ENDPOINT                      = var.idp_config_OIDC_ME_ENDPOINT
    PROM_METRICS_PREFIX                   = var.idp_config_PROM_METRICS_PREFIX
    PROM_ENABLE_DEFAULT_METRICS           = var.idp_config_PROM_ENABLE_DEFAULT_METRICS
    IS_IDP_PROXY                          = var.idp_config_IS_IDP_PROXY
    OIDC_REGISTRATION_URI                 = var.idp_config_OIDC_REGISTRATION_URI
    NiamSvcAcc_Client_id                  = var.idp_config_NiamSvcAcc_Client_id
    NiamSvcAcc_username                   = var.idp_config_NiamSvcAcc_username
    OIDC_URL                              = var.idp_config_OIDC_URL
    DB_TYPE                               = var.three_edges_DB_TYPE
    DB_VERSION                            = var.three_edges_DB_VERSION
    DB_HOST                               = var.three_edges_DB_HOST
    DB_NAME                               = var.three_edges_DB_NAME
    DB_USER                               = var.three_edges_DB_USER
    ACCESS_TOKEN_TYPE                     = var.idp_config_ACCESS_TOKEN_TYPE
    CONSENT_PAGE                          = var.idp_config_CONSENT_PAGE
    OIDC_URL_3EDGES                       = var.idp_config_OIDC_URL_3EDGES
    CLIENT_ID_3EDGES                      = var.idp_config_CLIENT_ID_3EDGES
    COOKIE_NNCE                           = var.idp_config_COOKIE_NNCE
    COOKIE_PRIMSCOOKIE                    = var.idp_config_COOKIE_PRIMSCOOKIE
    COOKIE_NID                            = var.idp_config_COOKIE_NID
    COOKIE_PKEY                           = var.idp_config_COOKIE_PKEY
    SOCIAL_GOOGLE_CLIENT_ID               = var.idp_config_SOCIAL_GOOGLE_CLIENT_ID
    SOCIAL_GOOGLE_OIDC_URL                = var.idp_config_SOCIAL_GOOGLE_OIDC_URL
    SOCIAL_GOOGLE_JWKS_URI                = var.idp_config_SOCIAL_GOOGLE_JWKS_URI
    PRIM_UI_CLIENT_ID                     = var.idp_config_PRIM_UI_CLIENT_ID
    OIDC_REFRESH_TOKEN_EXPIRE             = var.idp_config_OIDC_REFRESH_TOKEN_EXPIRE
    CONFIG_URL                            = var.idp_config_CONFIG_URL
    DB_RECORDS_BATCH_SIZE                 = var.idp_config_DB_RECORDS_BATCH_SIZE
    REDIS_HOST                            = var.idp_config_REDIS_HOST
    REDIS_PORT                            = var.idp_config_REDIS_PORT
  }



  depends_on = [var.kubernetes_namespace_namespace]
}

resource "kubernetes_config_map" "ui_config" {
  metadata {
    name      = "ui-config"
    namespace = "3edges"
  }

  data = {
    NODE_ENV                                     = var.ui_config_NODE_ENV
    PORT                                         = var.ui_config_PORT
    REACT_APP_ACCESS_TOKEN_COOKIE_NAME           = var.ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
    REACT_APP_NONCE_COOKIE_NAME                  = var.ui_config_REACT_APP_NONCE_COOKIE_NAME
    REACT_APP_ID_TOKEN_COOKIE_NAME               = var.ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
    REACT_APP_PKEY_COOKIE_NAME                   = var.ui_config_REACT_APP_PKEY_COOKIE_NAME
    REACT_APP_ENABLE_SELFREGISTRATION            = var.ui_config_REACT_APP_ENABLE_SELFREGISTRATION
    REACT_APP_JWKS_URI                           = var.ui_config_REACT_APP_JWKS_URI
    REACT_APP_OIDC_CLIENT_ID                     = var.ui_config_REACT_APP_OIDC_CLIENT_ID
    REACT_APP_OIDC_AUTH_ENDPOINT                 = var.ui_config_REACT_APP_OIDC_AUTH_ENDPOINT
    REACT_APP_URL_UI                             = var.ui_config_REACT_APP_URL_UI
    REACT_APP_OIDC_TOKEN_ENDPOINT                = var.ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT
    REACT_APP_OIDC_URL                           = var.ui_config_REACT_APP_OIDC_URL
    REACT_APP_PRIM_BACKEND_URI                   = var.ui_config_REACT_APP_PRIM_BACKEND_URI
    REACT_APP_ENABLE_NEWCLUSTER                  = var.ui_config_REACT_APP_ENABLE_NEWCLUSTER
    REACT_APP_config_PROXY                       = var.ui_config_REACT_APP_config_PROXY
    REACT_APP_NEWCLUSTER_PROXY                   = var.ui_config_REACT_APP_NEWCLUSTER_PROXY
    REACT_APP_config_IDP                         = var.ui_config_REACT_APP_config_IDP
    REACT_APP_NEWCLUSTER_IDP                     = var.ui_config_REACT_APP_NEWCLUSTER_IDP
    REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME   = var.ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME
    REACT_APP_IDLE_TIME_IN_MINUTES               = var.ui_config_REACT_APP_IDLE_TIME_IN_MINUTES
    REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME = var.ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME
    REACT_APP_WEBLOADER_URL                      = var.ui_config_REACT_APP_WEBLOADER_URL
    REACT_APP_CONTENT_SECURITY_POLICY            = var.ui_config_REACT_APP_CONTENT_SECURITY_POLICY
    REACT_APP_3EDGES_PROXY                       = "https://tmp-random-url.${var.hosted_zone}"
    REACT_APP_3EDGES_IDP                         = "https://tmp-random-url.${var.hosted_zone}/oidc"
    REACT_APP_API_NAME                           = local.api_name
    REACT_APP_DOMAIN                             = var.hosted_zone
  }

  depends_on = [var.kubernetes_namespace_namespace]
}
