
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


# extracting the root doamin from subdomain
locals {
  domain_parts = split(".", var.hosted_zone)
  root_domain  = length(local.domain_parts) > 2 ? join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts))) : var.hosted_zone

  # Condition to determine if the hosted zone is a root domain or not
  # For example, check if the hosted zone is equal to root_domain
  is_root_domain = var.hosted_zone == local.root_domain
}

# Look up the existing hosted zone for the parent domain
data "aws_route53_zone" "parent_domain" {
  count        = local.is_root_domain ? 0 : 1
  name = local.root_domain
  private_zone = false
}

# Conditionally create a new hosted zone if the parent domain doesn't exist
resource "aws_route53_zone" "hosted_zone" {
  count = length(data.aws_route53_zone.parent_domain) == 0 ? 1 : 0  # Only create if not found
  name = local.root_domain
}

locals {
  zone_id = length(data.aws_route53_zone.parent_domain) > 0 ? data.aws_route53_zone.parent_domain[0].zone_id : aws_route53_zone.hosted_zone[0].id
}

# Add wildcard CNAME record (for subdomains)
resource "aws_route53_record" "route53_wildcard_cname" {
  zone_id = local.zone_id
  name    = "*.${var.hosted_zone}."
  type    = "CNAME"
  ttl     = 300
  records = [data.aws_lb.nginx_load_balancer.dns_name]

  depends_on = [helm_release.ingress_nginx]
}

# Add an A record for the root domain
resource "aws_route53_record" "ingress_nginx" {
  zone_id = local.zone_id
  name    = "${var.hosted_zone}."   # Root domain record
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
  version    = "v1.14.4"
  timeout    = "3600"

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [helm_release.ingress_nginx, kubernetes_namespace.cert_manager_namespace]
}


module "deployments" {
  source                          = "./deployments"
  cert_manager                    = kubernetes_namespace.cert_manager_namespace.metadata[0].name
  ingress_nginx                   = helm_release.ingress_nginx
  hosted_zone                     = var.hosted_zone
  aws_region                      = var.aws_region
  aws_access_key_id               = var.aws_access_key_id
  aws_secret_access_key           = var.aws_secret_access_key
  aws_route53_zone_hosted_zone_id = local.zone_id
  aws_lb_nginx_load_balancer_zone_id = data.aws_lb.nginx_load_balancer.zone_id
  aws_lb_nginx_load_balancer_dns_name = data.aws_lb.nginx_load_balancer.dns_name
  kubernetes_namespace_namespace  = kubernetes_namespace.namespace
  aws_eks_cluster_auth_endpoint   = var.aws_eks_cluster_auth_endpoint
  eks_cluster                     = var.eks_cluster
  exclude_cluster_issuer          = var.exclude_cluster_issuer
  exclude_certificate             = var.exclude_certificate
  use_client_cert = var.use_client_cert
  client_cert_secret_name = var.client_cert_secret_name
  client_cert_file = var.client_cert_file
  client_key_file = var.client_key_file

  shared_secret_OIDC_CLIENT_PWD      = var.shared_secret_OIDC_CLIENT_PWD
  shared_secret_INTERNAL_SECRET      = var.shared_secret_INTERNAL_SECRET
  shared_config_PRIM_ADMIN_EMAIL     = var.shared_config_PRIM_ADMIN_EMAIL
  shared_config_SEND_EMAIL_FROM      = var.shared_config_SEND_EMAIL_FROM
  shared_config_SEND_EMAIL_FROM_NAME = var.shared_config_SEND_EMAIL_FROM_NAME

  three_edges_DB_TYPE            = var.three_edges_DB_TYPE
  three_edges_DB_VERSION         = var.three_edges_DB_VERSION
  three_edges_DB_HOST            = var.three_edges_DB_HOST
  three_edges_DB_NAME            = var.three_edges_DB_NAME
  three_edges_DB_USER            = var.three_edges_DB_USER
  three_edges_secret_DB_PASSWORD = var.three_edges_secret_DB_PASSWORD

  configuration_config_NODE_ENV                                      = var.configuration_config_NODE_ENV
  configuration_config_SERVER_PORT                                   = var.configuration_config_SERVER_PORT
  configuration_config_ENABLE_INTROSPECTION                          = var.configuration_config_ENABLE_INTROSPECTION
  configuration_config_ENABLE_PLAYGROUND                             = var.configuration_config_ENABLE_PLAYGROUND
  configuration_config_REACT_APP_OTP_VALIDITY                        = var.configuration_config_REACT_APP_OTP_VALIDITY
  configuration_config_SEND_EMAIL_URL                                = var.configuration_config_SEND_EMAIL_URL
  configuration_config_NEO4J_POOL_SIZE                               = var.configuration_config_NEO4J_POOL_SIZE
  configuration_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS       = var.configuration_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
  configuration_config_NEO4J_MAX_CONNECTION_LIFETIME                 = var.configuration_config_NEO4J_MAX_CONNECTION_LIFETIME
  configuration_config_NEO4J_CONNECTION_TIMEOUT                      = var.configuration_config_NEO4J_CONNECTION_TIMEOUT
  configuration_config_RESET_ADMIN_USER                              = var.configuration_config_RESET_ADMIN_USER
  configuration_config_NEO4J_URL_TEST                                = var.configuration_config_NEO4J_URL_TEST
  configuration_config_PRIM_CONFIG_NEO4J_DB_TEST                     = var.configuration_config_PRIM_CONFIG_NEO4J_DB_TEST
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN                  = var.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN
  configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN          = var.configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN
  configuration_config_CLUSTER_URL                                   = var.configuration_config_CLUSTER_URL
  configuration_config_COOKIE_NNCE                                   = var.configuration_config_COOKIE_NNCE
  configuration_config_COOKIE_PRIMSCOOKIE                            = var.configuration_config_COOKIE_PRIMSCOOKIE
  configuration_config_COOKIE_PKEY                                   = var.configuration_config_COOKIE_PKEY
  configuration_config_REDIS_HOST                                    = var.configuration_config_REDIS_HOST
  configuration_config_REDIS_PORT                                    = var.configuration_config_REDIS_PORT
  configuration_config_REDIS_TIMEOUT_GET_APISERVER_STATUS            = var.configuration_config_REDIS_TIMEOUT_GET_APISERVER_STATUS
  configuration_config_LOCALHOST_PROXY_DASHBOARD_URL                 = var.configuration_config_LOCALHOST_PROXY_DASHBOARD_URL
  configuration_config_LOCALHOST_PROXY_IDP_URL                       = var.configuration_config_LOCALHOST_PROXY_IDP_URL
  configuration_config_LOCALHOST_PROXY_AUTHORIZATION_URL             = var.configuration_config_LOCALHOST_PROXY_AUTHORIZATION_URL
  configuration_config_AUTHZ_POD_PORT                                = var.configuration_config_AUTHZ_POD_PORT
  configuration_config_DASHBOARD_POD_PORT                            = var.configuration_config_DASHBOARD_POD_PORT
  configuration_config_IDP_POD_PORT                                  = var.configuration_config_IDP_POD_PORT
  configuration_config_PROXY_POD_PORT                                = var.configuration_config_PROXY_POD_PORT
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = var.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD
  configuration_config_MAX_SHUTDOWN                                  = var.configuration_config_MAX_SHUTDOWN
  configuration_config_MAX_REDEPLOY                                  = var.configuration_config_MAX_REDEPLOY
  configuration_config_SEND_EMAIL_SERVER                             = var.configuration_config_SEND_EMAIL_SERVER
  configuration_config_COST_LIMIT_ENABLED                            = var.configuration_config_COST_LIMIT_ENABLED
  configuration_config_COST_LIMIT_MAXCOST                            = var.configuration_config_COST_LIMIT_MAXCOST
  configuration_config_COST_LIMIT_OBJECTCOST                         = var.configuration_config_COST_LIMIT_OBJECTCOST
  configuration_config_COST_LIMIT_SCALARCOST                         = var.configuration_config_COST_LIMIT_SCALARCOST
  configuration_config_COST_LIMIT_DEPTHCOSTFACTOR                    = var.configuration_config_COST_LIMIT_DEPTHCOSTFACTOR
  configuration_config_COST_LIMIT_IGNOREINTROSPECTION                = var.configuration_config_COST_LIMIT_IGNOREINTROSPECTION
  configuration_config_COST_LIMIT_N                                  = var.configuration_config_COST_LIMIT_N
  configuration_config_MAX_ALIASES_ENABLED                           = var.configuration_config_MAX_ALIASES_ENABLED
  configuration_config_MAX_ALIASES_N                                 = var.configuration_config_MAX_ALIASES_N
  configuration_config_MAX_DIRECTIVES_N                              = var.configuration_config_MAX_DIRECTIVES_N
  configuration_config_MAX_DEPTH_N                                   = var.configuration_config_MAX_DEPTH_N
  configuration_config_MAX_TOKENS_N                                  = var.configuration_config_MAX_TOKENS_N
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP              = var.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP
  configuration_config_MAX_CHARACTERS_N                              = var.configuration_config_MAX_CHARACTERS_N
  configuration_config_PROCESS_TIMEOUT_N                             = var.configuration_config_PROCESS_TIMEOUT_N
  configuration_config_UI_PROCESS_TIMEOUT_N                          = var.configuration_config_UI_PROCESS_TIMEOUT_N
  configuration_config_DB_RECORDS_BATCH_SIZE                         = var.configuration_config_DB_RECORDS_BATCH_SIZE
  configuration_config_QUERY_COMPLEXITY_LIMIT                        = var.configuration_config_QUERY_COMPLEXITY_LIMIT
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY               = var.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY
  configuration_config_UI_URL                                        = var.configuration_config_UI_URL
  configuration_config_OIDC_URL                                      = var.configuration_config_OIDC_URL
  configuration_config_OIDC_CLIENT_ID                                = var.configuration_config_OIDC_CLIENT_ID

  configuration_config_secret_TOKEN_PIPELINE      = var.configuration_config_secret_TOKEN_PIPELINE
  configuration_config_secret_NEO4J_PASSWORD_TEST = var.configuration_config_secret_NEO4J_PASSWORD_TEST
  configuration_config_secret_SESSION_PIPELINE    = var.configuration_config_secret_SESSION_PIPELINE
  configuration_config_secret_PRIM_ADMIN_PASS     = var.configuration_config_secret_PRIM_ADMIN_PASS
  configuration_config_secret_PRIM_JWT_SECRET     = var.configuration_config_secret_PRIM_JWT_SECRET

  dataloader_ui_config_NODE_ENV                           = var.dataloader_ui_config_NODE_ENV
  dataloader_ui_config_PORT                               = var.dataloader_ui_config_PORT
  dataloader_ui_config_REACT_APP_DATALOADER_URL           = var.dataloader_ui_config_REACT_APP_DATALOADER_URL
  dataloader_ui_config_REACT_APP_UI_URL_3EDGES            = var.dataloader_ui_config_REACT_APP_UI_URL_3EDGES
  dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME = var.dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
  dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME        = var.dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME
  dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME         = var.dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME
  dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME     = var.dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
  dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID           = var.dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID
  dataloader_ui_config_REACT_APP_OIDC_URL                 = var.dataloader_ui_config_REACT_APP_OIDC_URL
  dataloader_ui_config_REACT_APP_JWKS_URI                 = var.dataloader_ui_config_REACT_APP_JWKS_URI
  dataloader_ui_config_REACT_APP_DOCUMENTATION_URL        = var.dataloader_ui_config_REACT_APP_DOCUMENTATION_URL

  dataloader_config_NODE_ENV                                = var.dataloader_config_NODE_ENV
  dataloader_config_CORS_ORIGIN                             = var.dataloader_config_CORS_ORIGIN
  dataloader_config_PORT                                    = var.dataloader_config_PORT
  dataloader_config_NEO4J_POOL_SIZE                         = var.dataloader_config_NEO4J_POOL_SIZE
  dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS = var.dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
  dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME           = var.dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME
  dataloader_config_NEO4J_CONNECTION_TIMEOUT                = var.dataloader_config_NEO4J_CONNECTION_TIMEOUT
  dataloader_config_OIDC_URL                                = var.dataloader_config_OIDC_URL
  dataloader_config_OIDC_CLIENT_ID                          = var.dataloader_config_OIDC_CLIENT_ID
  dataloader_config_CONFIGURATION_URL                       = var.dataloader_config_CONFIGURATION_URL

  cluster_config_NODE_ENV          = var.cluster_config_NODE_ENV
  cluster_config_PORT              = var.cluster_config_PORT
  cluster_config_UI_URL            = var.cluster_config_UI_URL
  cluster_config_CLIENT_EMAIL      = var.cluster_config_CLIENT_EMAIL
  cluster_config_OIDC_URL          = var.cluster_config_OIDC_URL
  cluster_config_OIDC_CLIENT_ID    = var.cluster_config_OIDC_CLIENT_ID
  cluster_config_config_CLUSTER    = var.cluster_config_config_CLUSTER
  cluster_config_config_LOCATION   = var.cluster_config_config_LOCATION
  cluster_config_NGINX_LB          = var.cluster_config_NGINX_LB
  cluster_config_CLUSTER_URL       = var.cluster_config_CLUSTER_URL
  cluster_config_SEND_EMAIL_URL    = var.cluster_config_SEND_EMAIL_URL
  cluster_config_SEND_EMAIL_SERVER = var.cluster_config_SEND_EMAIL_SERVER

  cluster_secret_PRIVATE_KEY      = var.cluster_secret_PRIVATE_KEY
  cluster_secret_CRON_PWD         = var.cluster_secret_CRON_PWD
  cluster_secret_SESSION_PIPELINE = var.cluster_secret_SESSION_PIPELINE
  cluster_secret_TOKEN_PIPELINE   = var.cluster_secret_TOKEN_PIPELINE

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
  ui_config_REACT_APP_CONTENT_SECURITY_POLICY            = var.ui_config_REACT_APP_CONTENT_SECURITY_POLICY


  ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE = var.ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE
  ui_secret_REACT_APP_CAPTCHA_V2           = var.ui_secret_REACT_APP_CAPTCHA_V2

  idp_config_NODE_ENV                              = var.idp_config_NODE_ENV
  idp_config_OIDC_PORT                             = var.idp_config_OIDC_PORT
  idp_config_SERVER_HTTP_CORS_ORIGIN               = var.idp_config_SERVER_HTTP_CORS_ORIGIN
  idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY = var.idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY
  idp_config_SERVER_HTTP_X_FRAME_OPTIONS           = var.idp_config_SERVER_HTTP_X_FRAME_OPTIONS
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

  api_name = var.api_name
  PROM_METRICS_PREFIX = var.PROM_METRICS_PREFIX

  manual_api_deployment = var.manual_api_deployment 


  providers = {
    kubernetes = kubernetes
  }
}
