variable "hosted_zone" {}

variable "aws_region" {}

variable "aws_route53_zone_hosted_zone_id" {}

variable "cert_manager" {}

variable "ingress_nginx" {}

variable "kubernetes_namespace_namespace" {}

variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}

variable "aws_eks_cluster_auth_endpoint" {}

variable "exclude_cluster_issuer" {}

variable "exclude_certificate" {}

# This section of following variables are for kubernetes/deployments/configmap : configuration_config
variable "config_NODE_ENV" {}

variable "config_SERVER_PORT" {}

variable "config_ENABLE_INTROSPECTION" {}

variable "config_ENABLE_PLAYGROUND" {}

variable "config_REACT_APP_OTP_VALIDITY" {}

variable "config_SEND_EMAIL_FROM" {}

variable "config_SEND_EMAIL_FROM_NAME" {}

variable "config_SEND_EMAIL_URL" {}

variable "config_NEO4J_POOL_SIZE" {}

variable "config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS" {}

variable "config_NEO4J_MAX_CONNECTION_LIFETIME" {}

variable "config_NEO4J_CONNECTION_TIMEOUT" {}

variable "config_RESET_ADMIN_USER" {}

variable "config_PRIM_ADMIN_EMAIL" {}

variable "config_NEO4J_URL_TEST" {}

variable "config_PRIM_CONFIG_NEO4J_DB_TEST" {}

variable "config_PRIM_SERVER_HTTP_CORS_ORIGIN" {}

variable "config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN" {}

variable "config_DB_TYPE" {}

variable "config_DB_VERSION" {}

variable "config_DB_HOST" {}

variable "config_DB_NAME" {}

variable "config_DB_USER" {}

variable "config_CLUSTER_URL" {}

variable "config_COOKIE_NNCE" {}

variable "config_COOKIE_PRIMSCOOKIE" {}

variable "config_COOKIE_PKEY" {}

variable "config_REDIS_HOST" {}

variable "config_REDIS_PORT" {}

variable "config_REDIS_TIMEOUT_GET_APISERVER_STATUS" {}

variable "config_LOCALHOST_PROXY_DASHBOARD_URL" {}

variable "config_LOCALHOST_PROXY_IDP_URL" {}

variable "config_LOCALHOST_PROXY_AUTHORIZATION_URL" {}

variable "config_AUTHZ_POD_PORT" {}

variable "config_DASHBOARD_POD_PORT" {}

variable "config_IDP_POD_PORT" {}

variable "config_PROXY_POD_PORT" {}

variable "config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD" {}

variable "config_MAX_SHUTDOWN" {}

variable "config_MAX_REDEPLOY" {}

variable "config_SEND_EMAIL_SERVER" {}

variable "config_COST_LIMIT_ENABLED" {}

variable "config_COST_LIMIT_MAXCOST" {}

variable "config_COST_LIMIT_OBJECTCOST" {}

variable "config_COST_LIMIT_SCALARCOST" {}

variable "config_COST_LIMIT_DEPTHCOSTFACTOR" {}

variable "config_COST_LIMIT_IGNOREINTROSPECTION" {}

variable "config_COST_LIMIT_N" {}

variable "config_MAX_ALIASES_ENABLED" {}

variable "config_MAX_ALIASES_N" {}

variable "config_MAX_DIRECTIVES_N" {}

variable "config_MAX_DEPTH_N" {}

variable "config_MAX_TOKENS_N" {}

variable "config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP" {}

variable "config_MAX_CHARACTERS_N" {}

variable "config_PROCESS_TIMEOUT_N" {}

variable "config_UI_PROCESS_TIMEOUT_N" {}

variable "config_DB_RECORDS_BATCH_SIZE" {}

variable "config_QUERY_COMPLEXITY_LIMIT" {}

variable "config_DEFAULT_CONTENT_SECURITY_POLICY" {}

variable "config_UI_URL" {}

variable "config_OIDC_URL" {}

variable "config_OIDC_CLIENT_ID" {}

variable "config_secret_TOKEN_PIPELINE" {}

variable "config_secret_NEO4J_PASSWORD_TEST" {}

variable "config_secret_SESSION_PIPELINE" {}

variable "config_secret_DB_PASSWORD" {}

variable "config_secret_PRIM_ADMIN_PASS" {}

variable "config_secret_PRIM_JWT_SECRET" {}

variable "config_secret_OIDC_CLIENT_PWD" {}

variable "config_secret_INTERNAL_SECRET" {}

# This section of following variables are for kubernetes/deployments/configmap : dataloader_ui_config
variable "dl_ui_config_NODE_ENV" {}

variable "dl_ui_config_PORT" {}

variable "dl_ui_config_REACT_APP_DATALOADER_URL" {}

variable "dl_ui_config_REACT_APP_UI_URL_3EDGES" {}

variable "dl_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME" {}

variable "dl_ui_config_REACT_APP_NONCE_COOKIE_NAME" {}

variable "dl_ui_config_REACT_APP_PKEY_COOKIE_NAME" {}

variable "dl_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME" {}

variable "dl_ui_config_REACT_APP_OIDC_CLIENT_ID" {}

variable "dl_ui_config_REACT_APP_OIDC_URL" {}

variable "dl_ui_config_REACT_APP_JWKS_URI" {}

variable "dl_ui_config_REACT_APP_DOCUMENTATION_URL" {}

# This section of following variables are for kubernetes/deployments/secrets : dataloader_secrets
variable "dl_secret_dbPass" {}

variable "dl_secret_OIDC_CLIENT_PWD" {}

# This section of following variables are for kubernetes/deployments/configmap : dataloader_config
variable "dl_config_NODE_ENV" {}

variable "dl_config_CORS_ORIGIN" {}

variable "dl_config_PORT" {}

variable "dl_config_NEO4J_POOL_SIZE" {}

variable "dl_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS" {}

variable "dl_config_NEO4J_MAX_CONNECTION_LIFETIME" {}

variable "dl_config_NEO4J_CONNECTION_TIMEOUT" {}

variable "dl_config_dbName" {}

variable "dl_config_dbUser" {}

variable "dl_config_dbHost" {}

variable "dl_config_OIDC_URL" {}

variable "dl_config_OIDC_CLIENT_ID" {}

variable "dl_config_CONFIGURATION_URL" {}

# This section of following variables are for kubernetes/deployments/configmap : cluster_config
variable "cluster_config_NODE_ENV" {}

variable "cluster_config_PORT" {}

variable "cluster_config_UI_URL" {}

variable "cluster_config_CLIENT_EMAIL" {}

variable "cluster_config_OIDC_URL" {}

variable "cluster_config_OIDC_CLIENT_ID" {}

variable "cluster_config_config_CLUSTER" {}

variable "cluster_config_config_LOCATION" {}

variable "cluster_config_NGINX_LB" {}

variable "cluster_config_DB_TYPE" {}

variable "cluster_config_DB_VERSION" {}

variable "cluster_config_DB_HOST" {}

variable "cluster_config_DB_NAME" {}

variable "cluster_config_DB_USER" {}

variable "cluster_config_CLUSTER_URL" {}

variable "cluster_config_SEND_EMAIL_URL" {}

variable "cluster_config_SEND_EMAIL_SERVER" {}

variable "cluster_config_SEND_EMAIL_FROM" {}

variable "cluster_config_SEND_EMAIL_FROM_NAME" {}

variable "cluster_config_PRIM_ADMIN_EMAIL" {}

# This section of following variables are for kubernetes/deployments/secrets : cluster_secret
variable "cluster_secret_OIDC_CLIENT_PWD" {}

variable "cluster_secret_DB_PASSWORD" {}

variable "cluster_secret_PRIVATE_KEY" {}

variable "cluster_secret_CRON_PWD" {}

variable "cluster_secret_SESSION_PIPELINE" {}

variable "cluster_secret_TOKEN_PIPELINE" {}

variable "cluster_secret_INTERNAL_SECRET" {}

variable "idp_config_NODE_ENV" {}

variable "idp_config_OIDC_PORT" {}

variable "idp_config_SERVER_HTTP_CORS_ORIGIN" {}

variable "idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY" {}

variable "idp_config_SERVER_HTTP_X_FRAME_OPTIONS" {}

variable "idp_config_PRIM_ADMIN_EMAIL" {}

variable "idp_config_CHECK_VERIFIED" {}

variable "idp_config_NAMING_PROPERTY" {}

variable "idp_config_SUBJECT_TYPE" {}

variable "idp_config_AUTHN_QUERY" {}

variable "idp_config_AUTHN_QUERY_VERIFIED" {}

variable "idp_config_SOCIAL_URL" {}

variable "idp_config_CLAIMS_ARRAY" {}

variable "idp_config_OIDC_ACCESS_TOKEN_EXPIRE" {}

variable "idp_config_CONTENT_SECURITY_POLICY" {}

variable "idp_config_ALLOW_HTTP_REDIRECTS" {}

variable "idp_config_PRIM_UI_URL" {}

variable "idp_config_OIDC_AUTHORIZE_ENDPOINT" {}

variable "idp_config_OIDC_TOKEN_ENDPOINT" {}

variable "idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT" {}

variable "idp_config_OIDC_ME_ENDPOINT" {}

variable "idp_config_PROM_METRICS_PREFIX" {}

variable "idp_config_PROM_ENABLE_DEFAULT_METRICS" {}

variable "idp_config_IS_IDP_PROXY" {}

variable "idp_config_OIDC_REGISTRATION_URI" {}

variable "idp_config_NiamSvcAcc_Client_id" {}

variable "idp_config_NiamSvcAcc_username" {}

variable "idp_config_OIDC_URL" {}

variable "idp_config_DB_TYPE" {}

variable "idp_config_DB_VERSION" {}

variable "idp_config_DB_HOST" {}

variable "idp_config_DB_NAME" {}

variable "idp_config_DB_USER" {}

variable "idp_config_ACCESS_TOKEN_TYPE" {}

variable "idp_config_CONSENT_PAGE" {}

variable "idp_config_OIDC_URL_3EDGES" {}

variable "idp_config_CLIENT_ID_3EDGES" {}

variable "idp_config_COOKIE_NNCE" {}

variable "idp_config_COOKIE_PRIMSCOOKIE" {}

variable "idp_config_COOKIE_NID" {}

variable "idp_config_COOKIE_PKEY" {}

variable "idp_config_SOCIAL_GOOGLE_CLIENT_ID" {}

variable "idp_config_SOCIAL_GOOGLE_OIDC_URL" {}

variable "idp_config_SOCIAL_GOOGLE_JWKS_URI" {}

variable "idp_config_PRIM_UI_CLIENT_ID" {}

variable "idp_config_OIDC_REFRESH_TOKEN_EXPIRE" {}

variable "idp_config_CONFIG_URL" {}

variable "idp_config_DB_RECORDS_BATCH_SIZE" {}

variable "idp_config_REDIS_HOST" {}

variable "idp_config_REDIS_PORT" {}

# This section of following variables are for kubernetes/deployments/secrets : idp-secrets
variable "idp_secret_CLIENT_SECRET_ENC_KEY" {}

variable "idp_secret_NiamSvcAcc_Client_secret" {}

variable "idp_secret_NiamSvcAcc_pwd" {}

variable "idp_secret_DB_PASSWORD" {}

variable "idp_secret_CLIENT_PWD_3EDGES" {}

variable "idp_secret_INTERNAL_SECRET" {}


# This section of following variables are for kubernetes/deployments/configmap : ui-config
variable "ui_config_NODE_ENV" {}

variable "ui_config_PORT" {}

variable "ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME" {}

variable "ui_config_REACT_APP_NONCE_COOKIE_NAME" {}

variable "ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME" {}

variable "ui_config_REACT_APP_PKEY_COOKIE_NAME" {}

variable "ui_config_REACT_APP_ENABLE_SELFREGISTRATION" {}

variable "ui_config_REACT_APP_JWKS_URI" {}

variable "ui_config_REACT_APP_OIDC_CLIENT_ID" {}

variable "ui_config_REACT_APP_OIDC_AUTH_ENDPOINT" {}

variable "ui_config_REACT_APP_URL_UI" {}

variable "ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT" {}

variable "ui_config_REACT_APP_OIDC_URL" {}

variable "ui_config_REACT_APP_PRIM_BACKEND_URI" {}

variable "ui_config_REACT_APP_ENABLE_NEWCLUSTER" {}

variable "ui_config_REACT_APP_config_PROXY" {}

variable "ui_config_REACT_APP_NEWCLUSTER_PROXY" {}

variable "ui_config_REACT_APP_config_IDP" {}

variable "ui_config_REACT_APP_NEWCLUSTER_IDP" {}

variable "ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME" {}

variable "ui_config_REACT_APP_IDLE_TIME_IN_MINUTES" {}

variable "ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME" {}

variable "ui_config_REACT_APP_WEBLOADER_URL" {}

# This section of following variables are for kubernetes/deployments/secrets : ui_secrets
variable "ui_secret_REACT_APP_OIDC_CLIENT_PWD" {}

variable "ui_secret_REACT_APP_INTERNAL_SECRET" {}

variable "ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE" {}

variable "ui_secret_REACT_APP_CAPTCHA_V2" {}
