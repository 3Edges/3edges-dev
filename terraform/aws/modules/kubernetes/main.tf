
provider "kubernetes" {
  host                   = var.aws_eks_cluster_auth_endpoint
  cluster_ca_certificate = base64decode(var.aws_eks_cluster_auth_certificate)
  token                  = var.aws_eks_cluster_auth_token
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = "arn:aws:iam::${var.aws_caller_identity_id}:role/gIDP_admin"
        username = "gIDP_admin"
        groups = [
          "system:masters"
        ]
      },
      {
        rolearn  = "arn:aws:iam::${var.aws_caller_identity_id}:role/${var.eks_node_role}"
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:nodes",
          "system:bootstrappers"
        ]
      }
    ])
  }
}

provider "helm" {
  kubernetes {
    host                   = var.aws_eks_cluster_auth_endpoint
    cluster_ca_certificate = base64decode(var.aws_eks_cluster_auth_certificate)
    token                  = var.aws_eks_cluster_auth_token
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "3edges"
  }

}

resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    name = "cert-manager"
  }

}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.0.6"
  create_namespace = true
  timeout          = "3600"

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  depends_on = [var.aws_eks_node_group_eks_node_group]
}

resource "aws_route53_zone" "hosted_zone" {
  name = "${var.hosted_zone}."
}

resource "aws_route53_record" "route53_wildcard_cname" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = "*.${var.hosted_zone}."
  type    = "CNAME"
  ttl     = 300
  records = [data.aws_lb.nginx_load_balancer.dns_name]

  depends_on = [helm_release.ingress_nginx]
}

resource "aws_route53_record" "ingress_nginx" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = "${aws_route53_zone.hosted_zone.name}."
  type    = "A"

  alias {
    zone_id                = data.aws_lb.nginx_load_balancer.zone_id
    name                   = data.aws_lb.nginx_load_balancer.dns_name
    evaluate_target_health = false
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  # version    = "v1.12.3"
  version = "v1.14.4"
  timeout    = "3600"

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [helm_release.ingress_nginx, kubernetes_namespace.cert_manager_namespace]
}

module "deployments" {
  source                                               = "./deployments"
  cert_manager                                         = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  ingress_nginx                                        = helm_release.ingress_nginx
  hosted_zone                                          = var.hosted_zone
  aws_region                                           = var.aws_region
  aws_access_key_id                                    = var.aws_access_key_id
  aws_secret_access_key                                = var.aws_secret_access_key
  aws_route53_zone_hosted_zone_id                      = aws_route53_zone.hosted_zone.id
  kubernetes_namespace_namespace                       = kubernetes_namespace.namespace
  aws_eks_cluster_auth_endpoint                        = var.aws_eks_cluster_auth_endpoint
  exclude_cluster_issuer                               = var.exclude_cluster_issuer
  exclude_certificate                                  = var.exclude_certificate
  
  config_NODE_ENV                                      = var.config_NODE_ENV
  config_SERVER_PORT                                   = var.config_SERVER_PORT
  config_ENABLE_INTROSPECTION                          = var.config_ENABLE_INTROSPECTION
  config_ENABLE_PLAYGROUND                             = var.config_ENABLE_PLAYGROUND
  config_REACT_APP_OTP_VALIDITY                        = var.config_REACT_APP_OTP_VALIDITY
  config_SEND_EMAIL_FROM                               = var.config_SEND_EMAIL_FROM
  config_SEND_EMAIL_FROM_NAME                          = var.config_SEND_EMAIL_FROM_NAME
  config_SEND_EMAIL_URL                                = var.config_SEND_EMAIL_URL
  config_NEO4J_POOL_SIZE                               = var.config_NEO4J_POOL_SIZE
  config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS       = var.config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
  config_NEO4J_MAX_CONNECTION_LIFETIME                 = var.config_NEO4J_MAX_CONNECTION_LIFETIME
  config_NEO4J_CONNECTION_TIMEOUT                      = var.config_NEO4J_CONNECTION_TIMEOUT
  config_RESET_ADMIN_USER                              = var.config_RESET_ADMIN_USER
  config_PRIM_ADMIN_EMAIL                              = var.config_PRIM_ADMIN_EMAIL
  config_NEO4J_URL_TEST                                = var.config_NEO4J_URL_TEST
  config_PRIM_CONFIG_NEO4J_DB_TEST                     = var.config_PRIM_CONFIG_NEO4J_DB_TEST
  config_PRIM_SERVER_HTTP_CORS_ORIGIN                  = var.config_PRIM_SERVER_HTTP_CORS_ORIGIN
  config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN          = var.config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN
  config_DB_TYPE                                       = var.config_DB_TYPE
  config_DB_VERSION                                    = var.config_DB_VERSION
  config_DB_HOST                                       = var.config_DB_HOST
  config_DB_NAME                                       = var.config_DB_NAME
  config_DB_USER                                       = var.config_DB_USER
  config_CLUSTER_URL                                   = var.config_CLUSTER_URL
  config_COOKIE_NNCE                                   = var.config_COOKIE_NNCE
  config_COOKIE_PRIMSCOOKIE                            = var.config_COOKIE_PRIMSCOOKIE
  config_COOKIE_PKEY                                   = var.config_COOKIE_PKEY
  config_REDIS_HOST                                    = var.config_REDIS_HOST
  config_REDIS_PORT                                    = var.config_REDIS_PORT
  config_REDIS_TIMEOUT_GET_APISERVER_STATUS            = var.config_REDIS_TIMEOUT_GET_APISERVER_STATUS
  config_LOCALHOST_PROXY_DASHBOARD_URL                 = var.config_LOCALHOST_PROXY_DASHBOARD_URL
  config_LOCALHOST_PROXY_IDP_URL                       = var.config_LOCALHOST_PROXY_IDP_URL
  config_LOCALHOST_PROXY_AUTHORIZATION_URL             = var.config_LOCALHOST_PROXY_AUTHORIZATION_URL
  config_AUTHZ_POD_PORT                                = var.config_AUTHZ_POD_PORT
  config_DASHBOARD_POD_PORT                            = var.config_DASHBOARD_POD_PORT
  config_IDP_POD_PORT                                  = var.config_IDP_POD_PORT
  config_PROXY_POD_PORT                                = var.config_PROXY_POD_PORT
  config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = var.config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD
  config_MAX_SHUTDOWN                                  = var.config_MAX_SHUTDOWN
  config_MAX_REDEPLOY                                  = var.config_MAX_REDEPLOY
  config_SEND_EMAIL_SERVER                             = var.config_SEND_EMAIL_SERVER
  config_COST_LIMIT_ENABLED                            = var.config_COST_LIMIT_ENABLED
  config_COST_LIMIT_MAXCOST                            = var.config_COST_LIMIT_MAXCOST
  config_COST_LIMIT_OBJECTCOST                         = var.config_COST_LIMIT_OBJECTCOST
  config_COST_LIMIT_SCALARCOST                         = var.config_COST_LIMIT_SCALARCOST
  config_COST_LIMIT_DEPTHCOSTFACTOR                    = var.config_COST_LIMIT_DEPTHCOSTFACTOR
  config_COST_LIMIT_IGNOREINTROSPECTION                = var.config_COST_LIMIT_IGNOREINTROSPECTION
  config_COST_LIMIT_N                                  = var.config_COST_LIMIT_N
  config_MAX_ALIASES_ENABLED                           = var.config_MAX_ALIASES_ENABLED
  config_MAX_ALIASES_N                                 = var.config_MAX_ALIASES_N
  config_MAX_DIRECTIVES_N                              = var.config_MAX_DIRECTIVES_N
  config_MAX_DEPTH_N                                   = var.config_MAX_DEPTH_N
  config_MAX_TOKENS_N                                  = var.config_MAX_TOKENS_N
  config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP              = var.config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP
  config_MAX_CHARACTERS_N                              = var.config_MAX_CHARACTERS_N
  config_PROCESS_TIMEOUT_N                             = var.config_PROCESS_TIMEOUT_N
  config_UI_PROCESS_TIMEOUT_N                          = var.config_UI_PROCESS_TIMEOUT_N
  config_DB_RECORDS_BATCH_SIZE                         = var.config_DB_RECORDS_BATCH_SIZE
  config_QUERY_COMPLEXITY_LIMIT                        = var.config_QUERY_COMPLEXITY_LIMIT
  config_DEFAULT_CONTENT_SECURITY_POLICY               = var.config_DEFAULT_CONTENT_SECURITY_POLICY
  config_UI_URL                                        = var.config_UI_URL
  config_OIDC_URL                                      = var.config_OIDC_URL
  config_OIDC_CLIENT_ID                                = var.config_OIDC_CLIENT_ID
  
  config_secret_TOKEN_PIPELINE                         = var.config_secret_TOKEN_PIPELINE
  config_secret_NEO4J_PASSWORD_TEST                    = var.config_secret_NEO4J_PASSWORD_TEST
  config_secret_SESSION_PIPELINE                       = var.config_secret_SESSION_PIPELINE
  config_secret_DB_PASSWORD                            = var.config_secret_DB_PASSWORD
  config_secret_PRIM_ADMIN_PASS                        = var.config_secret_PRIM_ADMIN_PASS
  config_secret_PRIM_JWT_SECRET                        = var.config_secret_PRIM_JWT_SECRET
  config_secret_OIDC_CLIENT_PWD                        = var.config_secret_OIDC_CLIENT_PWD
  config_secret_INTERNAL_SECRET                        = var.config_secret_INTERNAL_SECRET
  
  dl_ui_config_NODE_ENV                                = var.dl_ui_config_NODE_ENV
  dl_ui_config_PORT                                    = var.dl_ui_config_PORT
  dl_ui_config_REACT_APP_DATALOADER_URL                = var.dl_ui_config_REACT_APP_DATALOADER_URL
  dl_ui_config_REACT_APP_UI_URL_3EDGES                 = var.dl_ui_config_REACT_APP_UI_URL_3EDGES
  dl_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME      = var.dl_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
  dl_ui_config_REACT_APP_NONCE_COOKIE_NAME             = var.dl_ui_config_REACT_APP_NONCE_COOKIE_NAME
  dl_ui_config_REACT_APP_PKEY_COOKIE_NAME              = var.dl_ui_config_REACT_APP_PKEY_COOKIE_NAME
  dl_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME          = var.dl_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
  dl_ui_config_REACT_APP_OIDC_CLIENT_ID                = var.dl_ui_config_REACT_APP_OIDC_CLIENT_ID
  dl_ui_config_REACT_APP_OIDC_URL                      = var.dl_ui_config_REACT_APP_OIDC_URL
  dl_ui_config_REACT_APP_JWKS_URI                      = var.dl_ui_config_REACT_APP_JWKS_URI
  dl_ui_config_REACT_APP_DOCUMENTATION_URL             = var.dl_ui_config_REACT_APP_DOCUMENTATION_URL
  
  dl_secret_dbPass                                     = var.dl_secret_dbPass
  dl_secret_OIDC_CLIENT_PWD                            = var.dl_secret_OIDC_CLIENT_PWD

  dl_config_NODE_ENV                                   = var.dl_config_NODE_ENV
  dl_config_CORS_ORIGIN                                = var.dl_config_CORS_ORIGIN
  dl_config_PORT                                       = var.dl_config_PORT
  dl_config_NEO4J_POOL_SIZE                            = var.dl_config_NEO4J_POOL_SIZE
  dl_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS    = var.dl_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
  dl_config_NEO4J_MAX_CONNECTION_LIFETIME              = var.dl_config_NEO4J_MAX_CONNECTION_LIFETIME
  dl_config_NEO4J_CONNECTION_TIMEOUT                   = var.dl_config_NEO4J_CONNECTION_TIMEOUT
  dl_config_dbName                                     = var.dl_config_dbName
  dl_config_dbUser                                     = var.dl_config_dbUser
  dl_config_dbHost                                     = var.dl_config_dbHost
  dl_config_OIDC_URL                                   = var.dl_config_OIDC_URL
  dl_config_OIDC_CLIENT_ID                             = var.dl_config_OIDC_CLIENT_ID
  dl_config_CONFIGURATION_URL                          = var.dl_config_CONFIGURATION_URL

  cluster_config_NODE_ENV                              = var.cluster_config_NODE_ENV
  cluster_config_PORT                                  = var.cluster_config_PORT
  cluster_config_UI_URL                                = var.cluster_config_UI_URL
  cluster_config_CLIENT_EMAIL                          = var.cluster_config_CLIENT_EMAIL
  cluster_config_OIDC_URL                              = var.cluster_config_OIDC_URL
  cluster_config_OIDC_CLIENT_ID                        = var.cluster_config_OIDC_CLIENT_ID
  cluster_config_config_CLUSTER                        = var.cluster_config_config_CLUSTER
  cluster_config_config_LOCATION                       = var.cluster_config_config_LOCATION
  cluster_config_NGINX_LB                              = var.cluster_config_NGINX_LB
  cluster_config_DB_TYPE                               = var.cluster_config_DB_TYPE
  cluster_config_DB_VERSION                            = var.cluster_config_DB_VERSION
  cluster_config_DB_HOST                               = var.cluster_config_DB_HOST
  cluster_config_DB_NAME                               = var.cluster_config_DB_NAME
  cluster_config_DB_USER                               = var.cluster_config_DB_USER
  cluster_config_CLUSTER_URL                           = var.cluster_config_CLUSTER_URL
  cluster_config_SEND_EMAIL_URL                        = var.cluster_config_SEND_EMAIL_URL
  cluster_config_SEND_EMAIL_SERVER                     = var.cluster_config_SEND_EMAIL_SERVER
  cluster_config_SEND_EMAIL_FROM                       = var.cluster_config_SEND_EMAIL_FROM
  cluster_config_SEND_EMAIL_FROM_NAME                  = var.cluster_config_SEND_EMAIL_FROM_NAME
  cluster_config_PRIM_ADMIN_EMAIL                      = var.cluster_config_PRIM_ADMIN_EMAIL

  cluster_secret_OIDC_CLIENT_PWD      = var.cluster_secret_OIDC_CLIENT_PWD
  cluster_secret_DB_PASSWORD          = var.cluster_secret_DB_PASSWORD
  cluster_secret_PRIVATE_KEY          = var.cluster_secret_PRIVATE_KEY
  cluster_secret_CRON_PWD             = var.cluster_secret_CRON_PWD
  cluster_secret_SESSION_PIPELINE     = var.cluster_secret_SESSION_PIPELINE
  cluster_secret_TOKEN_PIPELINE       = var.cluster_secret_TOKEN_PIPELINE
  cluster_secret_INTERNAL_SECRET      = var.cluster_secret_INTERNAL_SECRET

  ui_config_NODE_ENV                                     = var.ui_config_NODE_ENV
  ui_config_PORT                                         = var.ui_config_PORT
  ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME           = var.ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
  ui_config_REACT_APP_NONCE_COOKIE_NAME                  = var.ui_config_REACT_APP_NONCE_COOKIE_NAME
  ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME               = var.ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
  ui_config_REACT_APP_PKEY_COOKIE_NAME                   = var.ui_config_REACT_APP_PKEY_COOKIE_NAME
  ui_config_REACT_APP_ENABLE_SELFREGISTRATION            = var.ui_config_REACT_APP_ENABLE_SELFREGISTRATION
  ui_config_REACT_APP_JWKS_URI                           = var.ui_config_REACT_APP_JWKS_URI
  ui_config_REACT_APP_OIDC_CLIENT_ID                     = var.ui_config_REACT_APP_OIDC_CLIENT_ID
  ui_config_REACT_APP_OIDC_AUTH_ENDPOINT                 = var.ui_config_REACT_APP_OIDC_AUTH_ENDPOINT
  ui_config_REACT_APP_URL_UI                             = var.ui_config_REACT_APP_URL_UI
  ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT                = var.ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT
  ui_config_REACT_APP_OIDC_URL                           = var.ui_config_REACT_APP_OIDC_URL
  ui_config_REACT_APP_PRIM_BACKEND_URI                   = var.ui_config_REACT_APP_PRIM_BACKEND_URI
  ui_config_REACT_APP_ENABLE_NEWCLUSTER                  = var.ui_config_REACT_APP_ENABLE_NEWCLUSTER
  ui_config_REACT_APP_config_PROXY                       = var.ui_config_REACT_APP_config_PROXY
  ui_config_REACT_APP_NEWCLUSTER_PROXY                   = var.ui_config_REACT_APP_NEWCLUSTER_PROXY
  ui_config_REACT_APP_config_IDP                         = var.ui_config_REACT_APP_config_IDP
  ui_config_REACT_APP_NEWCLUSTER_IDP                     = var.ui_config_REACT_APP_NEWCLUSTER_IDP
  ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME   = var.ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME
  ui_config_REACT_APP_IDLE_TIME_IN_MINUTES               = var.ui_config_REACT_APP_IDLE_TIME_IN_MINUTES
  ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME = var.ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME
  ui_config_REACT_APP_WEBLOADER_URL                      = var.ui_config_REACT_APP_WEBLOADER_URL

  ui_secret_REACT_APP_OIDC_CLIENT_PWD      = var.ui_secret_REACT_APP_OIDC_CLIENT_PWD
  ui_secret_REACT_APP_INTERNAL_SECRET      = var.ui_secret_REACT_APP_INTERNAL_SECRET
  ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE = var.ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE
  ui_secret_REACT_APP_CAPTCHA_V2           = var.ui_secret_REACT_APP_CAPTCHA_V2

  idp_config_NODE_ENV                              = var.idp_config_NODE_ENV
  idp_config_OIDC_PORT                             = var.idp_config_OIDC_PORT
  idp_config_SERVER_HTTP_CORS_ORIGIN               = var.idp_config_SERVER_HTTP_CORS_ORIGIN
  idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY = var.idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY
  idp_config_SERVER_HTTP_X_FRAME_OPTIONS           = var.idp_config_SERVER_HTTP_X_FRAME_OPTIONS
  idp_config_PRIM_ADMIN_EMAIL                      = var.idp_config_PRIM_ADMIN_EMAIL
  idp_config_CHECK_VERIFIED                        = var.idp_config_CHECK_VERIFIED
  idp_config_NAMING_PROPERTY                       = var.idp_config_NAMING_PROPERTY
  idp_config_SUBJECT_TYPE                          = var.idp_config_SUBJECT_TYPE
  idp_config_AUTHN_QUERY                           = var.idp_config_AUTHN_QUERY
  idp_config_AUTHN_QUERY_VERIFIED                  = var.idp_config_AUTHN_QUERY_VERIFIED
  idp_config_SOCIAL_URL                            = var.idp_config_SOCIAL_URL
  idp_config_CLAIMS_ARRAY                          = var.idp_config_CLAIMS_ARRAY
  idp_config_OIDC_ACCESS_TOKEN_EXPIRE              = var.idp_config_OIDC_ACCESS_TOKEN_EXPIRE
  idp_config_CONTENT_SECURITY_POLICY               = var.idp_config_CONTENT_SECURITY_POLICY
  idp_config_ALLOW_HTTP_REDIRECTS                  = var.idp_config_ALLOW_HTTP_REDIRECTS
  idp_config_PRIM_UI_URL                           = var.idp_config_PRIM_UI_URL
  idp_config_OIDC_AUTHORIZE_ENDPOINT               = var.idp_config_OIDC_AUTHORIZE_ENDPOINT
  idp_config_OIDC_TOKEN_ENDPOINT                   = var.idp_config_OIDC_TOKEN_ENDPOINT
  idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT     = var.idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT
  idp_config_OIDC_ME_ENDPOINT                      = var.idp_config_OIDC_ME_ENDPOINT
  idp_config_PROM_METRICS_PREFIX                   = var.idp_config_PROM_METRICS_PREFIX
  idp_config_PROM_ENABLE_DEFAULT_METRICS           = var.idp_config_PROM_ENABLE_DEFAULT_METRICS
  idp_config_IS_IDP_PROXY                          = var.idp_config_IS_IDP_PROXY
  idp_config_OIDC_REGISTRATION_URI                 = var.idp_config_OIDC_REGISTRATION_URI
  idp_config_NiamSvcAcc_Client_id                  = var.idp_config_NiamSvcAcc_Client_id
  idp_config_NiamSvcAcc_username                   = var.idp_config_NiamSvcAcc_username
  idp_config_OIDC_URL                              = var.idp_config_OIDC_URL
  idp_config_DB_TYPE                               = var.idp_config_DB_TYPE
  idp_config_DB_VERSION                            = var.idp_config_DB_VERSION
  idp_config_DB_HOST                               = var.idp_config_DB_HOST
  idp_config_DB_NAME                               = var.idp_config_DB_NAME
  idp_config_DB_USER                               = var.idp_config_DB_USER
  idp_config_ACCESS_TOKEN_TYPE                     = var.idp_config_ACCESS_TOKEN_TYPE
  idp_config_CONSENT_PAGE                          = var.idp_config_CONSENT_PAGE
  idp_config_OIDC_URL_3EDGES                       = var.idp_config_OIDC_URL_3EDGES
  idp_config_CLIENT_ID_3EDGES                      = var.idp_config_CLIENT_ID_3EDGES
  idp_config_COOKIE_NNCE                           = var.idp_config_COOKIE_NNCE
  idp_config_COOKIE_PRIMSCOOKIE                    = var.idp_config_COOKIE_PRIMSCOOKIE
  idp_config_COOKIE_NID                            = var.idp_config_COOKIE_NID
  idp_config_COOKIE_PKEY                           = var.idp_config_COOKIE_PKEY
  idp_config_SOCIAL_GOOGLE_CLIENT_ID               = var.idp_config_SOCIAL_GOOGLE_CLIENT_ID
  idp_config_SOCIAL_GOOGLE_OIDC_URL                = var.idp_config_SOCIAL_GOOGLE_OIDC_URL
  idp_config_SOCIAL_GOOGLE_JWKS_URI                = var.idp_config_SOCIAL_GOOGLE_JWKS_URI
  idp_config_PRIM_UI_CLIENT_ID                     = var.idp_config_PRIM_UI_CLIENT_ID
  idp_config_OIDC_REFRESH_TOKEN_EXPIRE             = var.idp_config_OIDC_REFRESH_TOKEN_EXPIRE
  idp_config_CONFIG_URL                            = var.idp_config_CONFIG_URL
  idp_config_DB_RECORDS_BATCH_SIZE                 = var.idp_config_DB_RECORDS_BATCH_SIZE
  idp_config_REDIS_HOST                            = var.idp_config_REDIS_HOST
  idp_config_REDIS_PORT                            = var.idp_config_REDIS_PORT

  idp_secret_CLIENT_SECRET_ENC_KEY    = var.idp_secret_CLIENT_SECRET_ENC_KEY
  idp_secret_NiamSvcAcc_Client_secret = var.idp_secret_NiamSvcAcc_Client_secret
  idp_secret_NiamSvcAcc_pwd           = var.idp_secret_NiamSvcAcc_pwd
  idp_secret_DB_PASSWORD              = var.idp_secret_DB_PASSWORD
  idp_secret_CLIENT_PWD_3EDGES        = var.idp_secret_CLIENT_PWD_3EDGES
  idp_secret_INTERNAL_SECRET          = var.idp_secret_INTERNAL_SECRET

  providers = {
    kubernetes = kubernetes
  }
}
