provider "aws" {
  region = var.aws_region
}

module "iam" {
  source        = "./modules/iam"
  eks_role      = var.eks_role
  eks_node_role = var.eks_node_role
  aws_region    = var.aws_region
}

module "vpc" {
  source               = "./modules/vpc"
  eks_vpc              = var.eks_vpc
  eks_internet_gateway = var.eks_internet_gateway
  eks_route_table      = var.eks_route_table
  eks_security_group   = var.eks_security_group

  depends_on = [module.iam]
}

module "cluster" {
  source                                 = "./modules/cluster"
  eks_cluster                            = var.eks_cluster
  eks_node_group                         = var.eks_node_group
  eks_subnet                             = module.vpc.eks_subnet
  iam_role_arn                           = module.iam.iam_role_arn
  aws_iam_role                           = module.iam.aws_iam_role
  iam_eks_policy                         = module.iam.iam_eks_policy
  iam_eks_vpc_resource_controller_policy = module.iam.iam_eks_vpc_resource_controller_policy
  eks_worker_node_policy                 = module.iam.eks_worker_node_policy
  eks_cni_policy                         = module.iam.eks_cni_policy
  ec2_container_registry_readonly        = module.iam.ec2_container_registry_readonly
  route53_full_access                    = module.iam.route53_full_access

  depends_on = [module.vpc]
}

module "kubernetes" {
  source                            = "./modules/kubernetes"
  aws_eks_cluster_auth_token        = module.cluster.aws_eks_cluster_auth_token
  aws_eks_cluster_auth_endpoint     = module.cluster.aws_eks_cluster_auth_endpoint
  aws_eks_node_group_eks_node_group = module.cluster.aws_eks_node_group_eks_node_group
  aws_eks_cluster_auth_certificate  = module.cluster.aws_eks_cluster_auth_certificate
  aws_eks_cluster_eks_cluster_id    = module.cluster.aws_eks_cluster_eks_cluster_id
  aws_eks_cluster_eks_cluster_name  = module.cluster.aws_eks_cluster_eks_cluster_name
  eks_cluster                       = var.eks_cluster
  aws_region                        = var.aws_region
  hosted_zone                       = var.hosted_zone
  eks_node_role                     = var.eks_node_role
  aws_caller_identity_id            = data.aws_caller_identity.current.account_id
  aws_access_key_id                 = var.aws_access_key_id
  aws_secret_access_key             = var.aws_secret_access_key
  exclude_cluster_issuer            = var.exclude_cluster_issuer
  exclude_certificate               = var.exclude_certificate

  shared_secret_OIDC_CLIENT_PWD      = random_password.shared_secret_OIDC_CLIENT_PWD.result
  shared_secret_INTERNAL_SECRET      = random_password.shared_secret_INTERNAL_SECRET.result
  shared_config_PRIM_ADMIN_EMAIL     = var.shared_config_PRIM_ADMIN_EMAIL
  shared_config_SEND_EMAIL_FROM      = var.shared_config_SEND_EMAIL_FROM
  shared_config_SEND_EMAIL_FROM_NAME = var.shared_config_SEND_EMAIL_FROM_NAME


  # This section is for DB (idp, configuration) will be addressed as three_edges_<DB>
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
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN                  = local.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN
  configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN          = local.configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN
  configuration_config_CLUSTER_URL                                   = local.configuration_config_CLUSTER_URL
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
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = local.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD
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
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP              = local.configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP
  configuration_config_MAX_CHARACTERS_N                              = var.configuration_config_MAX_CHARACTERS_N
  configuration_config_PROCESS_TIMEOUT_N                             = var.configuration_config_PROCESS_TIMEOUT_N
  configuration_config_UI_PROCESS_TIMEOUT_N                          = var.configuration_config_UI_PROCESS_TIMEOUT_N
  configuration_config_DB_RECORDS_BATCH_SIZE                         = var.configuration_config_DB_RECORDS_BATCH_SIZE
  configuration_config_QUERY_COMPLEXITY_LIMIT                        = var.configuration_config_QUERY_COMPLEXITY_LIMIT
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY               = local.configuration_config_DEFAULT_CONTENT_SECURITY_POLICY
  configuration_config_UI_URL                                        = local.configuration_config_UI_URL
  configuration_config_OIDC_URL                                      = local.configuration_config_OIDC_URL
  configuration_config_OIDC_CLIENT_ID                                = var.configuration_config_OIDC_CLIENT_ID

  configuration_config_secret_TOKEN_PIPELINE      = var.configuration_config_secret_TOKEN_PIPELINE
  configuration_config_secret_NEO4J_PASSWORD_TEST = var.configuration_config_secret_NEO4J_PASSWORD_TEST
  configuration_config_secret_SESSION_PIPELINE    = var.configuration_config_secret_SESSION_PIPELINE
  configuration_config_secret_PRIM_ADMIN_PASS     = var.configuration_config_secret_PRIM_ADMIN_PASS
  configuration_config_secret_PRIM_JWT_SECRET     = random_password.configuration_config_secret_PRIM_JWT_SECRET.result

  dataloader_ui_config_NODE_ENV                           = var.dataloader_ui_config_NODE_ENV
  dataloader_ui_config_PORT                               = var.dataloader_ui_config_PORT
  dataloader_ui_config_REACT_APP_DATALOADER_URL           = local.dataloader_ui_config_REACT_APP_DATALOADER_URL
  dataloader_ui_config_REACT_APP_UI_URL_3EDGES            = local.dataloader_ui_config_REACT_APP_UI_URL_3EDGES
  dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME = var.dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME
  dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME        = var.dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME
  dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME         = var.dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME
  dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME     = var.dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME
  dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID           = var.dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID
  dataloader_ui_config_REACT_APP_OIDC_URL                 = local.dataloader_ui_config_REACT_APP_OIDC_URL
  dataloader_ui_config_REACT_APP_JWKS_URI                 = var.dataloader_ui_config_REACT_APP_JWKS_URI
  dataloader_ui_config_REACT_APP_DOCUMENTATION_URL        = var.dataloader_ui_config_REACT_APP_DOCUMENTATION_URL


  dataloader_config_NODE_ENV                                = var.dataloader_config_NODE_ENV
  dataloader_config_CORS_ORIGIN                             = var.dataloader_config_CORS_ORIGIN
  dataloader_config_PORT                                    = var.dataloader_config_PORT
  dataloader_config_NEO4J_POOL_SIZE                         = var.dataloader_config_NEO4J_POOL_SIZE
  dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS = var.dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS
  dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME           = var.dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME
  dataloader_config_NEO4J_CONNECTION_TIMEOUT                = var.dataloader_config_NEO4J_CONNECTION_TIMEOUT
  dataloader_config_OIDC_URL                                = local.dataloader_config_OIDC_URL
  dataloader_config_OIDC_CLIENT_ID                          = var.dataloader_config_OIDC_CLIENT_ID
  dataloader_config_CONFIGURATION_URL                       = local.dataloader_config_CONFIGURATION_URL

  cluster_config_NODE_ENV          = var.cluster_config_NODE_ENV
  cluster_config_PORT              = var.cluster_config_PORT
  cluster_config_UI_URL            = local.cluster_config_UI_URL
  cluster_config_CLIENT_EMAIL      = var.cluster_config_CLIENT_EMAIL
  cluster_config_OIDC_URL          = local.cluster_config_OIDC_URL
  cluster_config_OIDC_CLIENT_ID    = var.cluster_config_OIDC_CLIENT_ID
  cluster_config_config_CLUSTER    = var.cluster_config_config_CLUSTER
  cluster_config_config_LOCATION   = local.cluster_config_config_LOCATION
  cluster_config_NGINX_LB          = var.cluster_config_NGINX_LB
  cluster_config_CLUSTER_URL       = local.cluster_config_CLUSTER_URL
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
  ui_config_REACT_APP_URL_UI                             = local.ui_config_REACT_APP_URL_UI
  ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT                = var.ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT
  ui_config_REACT_APP_OIDC_URL                           = local.ui_config_REACT_APP_OIDC_URL
  ui_config_REACT_APP_PRIM_BACKEND_URI                   = local.ui_config_REACT_APP_PRIM_BACKEND_URI
  ui_config_REACT_APP_ENABLE_NEWCLUSTER                  = var.ui_config_REACT_APP_ENABLE_NEWCLUSTER
  ui_config_REACT_APP_config_PROXY                       = local.ui_config_REACT_APP_config_PROXY
  ui_config_REACT_APP_NEWCLUSTER_PROXY                   = local.ui_config_REACT_APP_NEWCLUSTER_PROXY
  ui_config_REACT_APP_config_IDP                         = local.ui_config_REACT_APP_config_IDP
  ui_config_REACT_APP_NEWCLUSTER_IDP                     = local.ui_config_REACT_APP_NEWCLUSTER_IDP
  ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME   = var.ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME
  ui_config_REACT_APP_IDLE_TIME_IN_MINUTES               = var.ui_config_REACT_APP_IDLE_TIME_IN_MINUTES
  ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME = var.ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME
  ui_config_REACT_APP_WEBLOADER_URL                      = local.ui_config_REACT_APP_WEBLOADER_URL
  ui_config_REACT_APP_CONTENT_SECURITY_POLICY            = local.ui_config_REACT_APP_CONTENT_SECURITY_POLICY

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
  idp_config_SOCIAL_URL                            = local.idp_config_SOCIAL_URL
  idp_config_CLAIMS_ARRAY                          = var.idp_config_CLAIMS_ARRAY
  idp_config_OIDC_ACCESS_TOKEN_EXPIRE              = var.idp_config_OIDC_ACCESS_TOKEN_EXPIRE
  idp_config_CONTENT_SECURITY_POLICY               = local.idp_config_CONTENT_SECURITY_POLICY
  idp_config_ALLOW_HTTP_REDIRECTS                  = var.idp_config_ALLOW_HTTP_REDIRECTS
  idp_config_PRIM_UI_URL                           = local.idp_config_PRIM_UI_URL
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
  idp_config_OIDC_URL                              = local.idp_config_OIDC_URL
  idp_config_ACCESS_TOKEN_TYPE                     = var.idp_config_ACCESS_TOKEN_TYPE
  idp_config_CONSENT_PAGE                          = var.idp_config_CONSENT_PAGE
  idp_config_OIDC_URL_3EDGES                       = local.idp_config_OIDC_URL_3EDGES
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
  idp_config_CONFIG_URL                            = local.idp_config_CONFIG_URL
  idp_config_DB_RECORDS_BATCH_SIZE                 = var.idp_config_DB_RECORDS_BATCH_SIZE
  idp_config_REDIS_HOST                            = var.idp_config_REDIS_HOST
  idp_config_REDIS_PORT                            = var.idp_config_REDIS_PORT

  idp_secret_CLIENT_SECRET_ENC_KEY    = random_password.idp_secret_CLIENT_SECRET_ENC_KEY.result
  idp_secret_NiamSvcAcc_Client_secret = random_password.idp_secret_NiamSvcAcc_Client_secret.result
  idp_secret_NiamSvcAcc_pwd           = random_password.idp_secret_NiamSvcAcc_pwd.result

  api_name              = var.api_name
  PROM_METRICS_PREFIX   = var.PROM_METRICS_PREFIX
  manual_api_deployment = var.manual_api_deployment


}

module "cypher" {
  source                        = "./modules/cypher"
  shared_secret_OIDC_CLIENT_PWD = random_password.shared_secret_OIDC_CLIENT_PWD.result
  shared_secret_INTERNAL_SECRET = random_password.shared_secret_INTERNAL_SECRET.result
  four_letter_random            = random_string.four_letter_random.result

  three_edges_DB_HOST            = var.three_edges_DB_HOST
  three_edges_DB_USER            = var.three_edges_DB_USER
  three_edges_secret_DB_PASSWORD = var.three_edges_secret_DB_PASSWORD
  hosted_zone                    = var.hosted_zone
  n_client_secret                = var.n_client_secret

  depends_on = [module.cluster, module.iam, module.kubernetes, module.vpc]

}
