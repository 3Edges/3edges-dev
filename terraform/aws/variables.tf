variable "aws_region" {
  default = "ca-west-1"
}

variable "hosted_zone" {
  default = "vanquisher.tech"
}

variable "eks_cluster" {
  default = "three-edges-cluster-praj"
}

variable "eks_role" {
  default = "three-edges-eks-role-praj"
}

variable "eks_node_role" {
  default = "three-edges-eks-node-role-praj"
}

variable "eks_node_group" {
  default = "three-edges-node-group-praj"
}

variable "eks_vpc" {
  default = "three-edges-eks-vpc-praj"
}

variable "eks_internet_gateway" {
  default = "three-edges-eks-igw-praj"
}

variable "eks_route_table" {
  default = "three-edges-eks-route-table-praj"
}

variable "eks_security_group" {
  default = "three-edges-eks-security-group-praj"
}

variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "exclude_cluster_issuer" {
  type    = bool
  default = false
}

variable "exclude_certificate" {
  type    = bool
  default = false
}

# This section of following variables are for kubernetes/deployments/configmap : configuration_config
variable "config_NODE_ENV" {
  type        = string
  description = "The environment in which the application is running"
  default     = "production"
}

variable "config_SERVER_PORT" {
  type        = string
  description = "The port on which the server listens"
  default     = "4005"
}

variable "config_ENABLE_INTROSPECTION" {
  type        = string
  description = "Whether to enable GraphQL introspection"
  default     = "true"
}

variable "config_ENABLE_PLAYGROUND" {
  type        = string
  description = "Whether to enable GraphQL playground"
  default     = "true"
}

variable "config_REACT_APP_OTP_VALIDITY" {
  type        = string
  description = "OTP validity period in minutes"
  default     = "2880"
}

variable "config_SEND_EMAIL_FROM" {
  type        = string
  description = "Email address from which emails are sent"
  default     = "noreply@abotega.ca"
}

variable "config_SEND_EMAIL_FROM_NAME" {
  type        = string
  description = "Name displayed as the sender in emails"
  default     = "3Edges"
}

variable "config_SEND_EMAIL_URL" {
  type        = string
  description = "URL used for sending emails"
  default     = "https://edges-305901.uw.r.appspot.com/api"
}

variable "config_NEO4J_POOL_SIZE" {
  type        = string
  description = "Neo4j connection pool size"
  default     = "300"
}

variable "config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS" {
  type        = string
  description = "Neo4j connection acquisition timeout in milliseconds"
  default     = "60000"
}

variable "config_NEO4J_MAX_CONNECTION_LIFETIME" {
  type        = string
  description = "Neo4j maximum connection lifetime in milliseconds"
  default     = "3600000"
}

variable "config_NEO4J_CONNECTION_TIMEOUT" {
  type        = string
  description = "Neo4j connection timeout in milliseconds"
  default     = "30000"
}

variable "config_RESET_ADMIN_USER" {
  type        = string
  description = "Whether to reset the admin user"
  default     = "true"
}

variable "config_PRIM_ADMIN_EMAIL" {
  type        = string
  description = "Primary admin email address"
  default     = "3admin@abotega.ca"
}

variable "config_NEO4J_URL_TEST" {
  type        = string
  description = "URL of the Neo4j test database"
  default     = "neo4j+s://9d49f282.databases.neo4j.io"
}

variable "config_PRIM_CONFIG_NEO4J_DB_TEST" {
  type        = string
  description = "Neo4j test database name"
  default     = "neo4j"
}

variable "config_PRIM_SERVER_HTTP_CORS_ORIGIN" {
  type        = string
  description = "CORS origin for the primary server"
  default     = "https://abotega.ca"
}

variable "config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN" {
  type        = string
  description = "Default CORS origin for the primary server"
  default     = "https://abotega.ca"
}

variable "config_DB_TYPE" {
  type        = string
  description = "Type of database used"
  default     = "neo4j"
}

variable "config_DB_VERSION" {
  type        = string
  description = "Version of the database"
  default     = "v5"
}

variable "config_DB_HOST" {
  type        = string
  description = "Host of the database"
  default     = "neo4j+s://ae61ebf7.databases.neo4j.io"
}

variable "config_DB_NAME" {
  type        = string
  description = "Name of the database"
  default     = "neo4j"
}

variable "config_DB_USER" {
  type        = string
  description = "Database username"
  default     = "neo4j"
}

variable "config_CLUSTER_URL" {
  type        = string
  description = "URL of the cluster"
  default     = "https://cluster.abotega.ca/api"
}

variable "config_COOKIE_NNCE" {
  type        = string
  description = "Cookie name for NNCE"
  default     = "nnce"
}

variable "config_COOKIE_PRIMSCOOKIE" {
  type        = string
  description = "Cookie name for PRIMSCOOKIE"
  default     = "primscookie"
}

variable "config_COOKIE_PKEY" {
  type        = string
  description = "Cookie name for PKEY"
  default     = "pkey"
}

variable "config_REDIS_HOST" {
  type        = string
  description = "Host of the Redis server"
  default     = "redis-headless"
}

variable "config_REDIS_PORT" {
  type        = string
  description = "Port of the Redis server"
  default     = "6379"
}

variable "config_REDIS_TIMEOUT_GET_APISERVER_STATUS" {
  type        = string
  description = "Timeout for getting API server status in seconds"
  default     = "30"
}

variable "config_LOCALHOST_PROXY_DASHBOARD_URL" {
  type        = string
  description = "Localhost proxy dashboard URL"
  default     = ""
}

variable "config_LOCALHOST_PROXY_IDP_URL" {
  type        = string
  description = "Localhost proxy IDP URL"
  default     = ""
}

variable "config_LOCALHOST_PROXY_AUTHORIZATION_URL" {
  type        = string
  description = "Localhost proxy authorization URL"
  default     = ""
}

variable "config_AUTHZ_POD_PORT" {
  type        = string
  description = "Port of the authorization pod"
  default     = "5055"
}

variable "config_DASHBOARD_POD_PORT" {
  type        = string
  description = "Port of the dashboard pod"
  default     = "3045"
}

variable "config_IDP_POD_PORT" {
  type        = string
  description = "Port of the IDP pod"
  default     = "3001"
}

variable "config_PROXY_POD_PORT" {
  type        = string
  description = "Port of the proxy pod"
  default     = "4044"
}

variable "config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD" {
  type        = string
  description = "Default Content Security Policy for API Dashboard"
  default     = "default-src 'self' *.abotega.ca https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com; script-src 'self' http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' www.gstatic.com/recaptcha data:; font-src 'self' https://fonts.gstatic.com; frame-src 'self' *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com; style-src 'self' https://fonts.googleapis.com 'unsafe-inline';"
}

variable "config_MAX_SHUTDOWN" {
  type        = string
  description = "Maximum shutdown time"
  default     = "20"
}

variable "config_MAX_REDEPLOY" {
  type        = string
  description = "Maximum redeploy count"
  default     = "5"
}

variable "config_SEND_EMAIL_SERVER" {
  type        = string
  description = "Email server environment"
  default     = "PROD"
}

variable "config_COST_LIMIT_ENABLED" {
  type        = string
  description = "Whether cost limiting is enabled"
  default     = "true"
}

variable "config_COST_LIMIT_MAXCOST" {
  type        = string
  description = "Maximum cost limit"
  default     = "300000"
}

variable "config_COST_LIMIT_OBJECTCOST" {
  type        = string
  description = "Object cost limit"
  default     = "5"
}

variable "config_COST_LIMIT_SCALARCOST" {
  type        = string
  description = "Scalar cost limit"
  default     = "5"
}

variable "config_COST_LIMIT_DEPTHCOSTFACTOR" {
  type        = string
  description = "Depth cost factor"
  default     = "2"
}

variable "config_COST_LIMIT_IGNOREINTROSPECTION" {
  type        = string
  description = "Whether to ignore introspection for cost limit"
  default     = "true"
}

variable "config_COST_LIMIT_N" {
  type        = string
  description = "Cost limit N"
  default     = "20"
}

variable "config_MAX_ALIASES_ENABLED" {
  type        = string
  description = "Whether max aliases is enabled"
  default     = "true"
}

variable "config_MAX_ALIASES_N" {
  type        = string
  description = "Maximum number of aliases"
  default     = "20"
}

variable "config_MAX_DIRECTIVES_N" {
  type        = string
  description = "Maximum number of directives"
  default     = "20"
}

variable "config_MAX_DEPTH_N" {
  type        = string
  description = "Maximum depth N"
  default     = "8"
}

variable "config_MAX_TOKENS_N" {
  type        = string
  description = "Maximum number of tokens"
  default     = "250"
}

variable "config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP" {
  type        = string
  description = "CORS origin for the IDP server"
  default     = "https://idp.abotega.ca"
}

variable "config_MAX_CHARACTERS_N" {
  type        = string
  description = "Maximum number of characters"
  default     = "15000"
}

variable "config_PROCESS_TIMEOUT_N" {
  type        = string
  description = "Process timeout"
  default     = "10000"
}

variable "config_UI_PROCESS_TIMEOUT_N" {
  type        = string
  description = "UI process timeout"
  default     = "100000"
}

variable "config_DB_RECORDS_BATCH_SIZE" {
  type        = string
  description = "Batch size for database records"
  default     = "10"
}

variable "config_QUERY_COMPLEXITY_LIMIT" {
  type        = string
  description = "Limit for query complexity"
  default     = "140000"
}

variable "config_DEFAULT_CONTENT_SECURITY_POLICY" {
  type        = string
  description = "Default Content Security Policy"
  default     = "default-src 'self' *.abotega.ca https://embeddable-sandbox.cdn.apollographql.com/ https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com https://apollo-server-landing-page.cdn.apollographql.com; script-src 'self' https://embeddable-sandbox.cdn.apollographql.com/ http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ https://apollo-server-landing-page.cdn.apollographql.com/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' https://apollo-server-landing-page.cdn.apollographql.com data:; frame-src 'self' https://sandbox.embed.apollographql.com/ *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com https://apollo-server-landing-page.cdn.apollographql.com; style-src 'self' https://fonts.googleapis.com https://apollo-server-landing-page.cdn.apollographql.com 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com https://apollo-server-landing-page.cdn.apollographql.com;"
}

variable "config_UI_URL" {
  type        = string
  description = "URL for the UI"
  default     = "https://abotega.ca"
}

variable "config_OIDC_URL" {
  type        = string
  description = "OIDC URL"
  default     = "https://idp.abotega.ca/oidc"
}

variable "config_OIDC_CLIENT_ID" {
  type        = string
  description = "OIDC client ID"
  default     = "3edgesConfigClient"
}

# This section of following variables are for kubernetes/deployments/secrets : configuration_secrets
variable "config_secret_TOKEN_PIPELINE" {
  description = "Token pipeline secret"
  type        = string
  default     = ""
}

variable "config_secret_NEO4J_PASSWORD_TEST" {
  description = "Neo4j password for the test environment"
  type        = string
  default     = ""
}

variable "config_secret_SESSION_PIPELINE" {
  description = "Session pipeline secret"
  type        = string
  default     = ""
}

variable "config_secret_DB_PASSWORD" {
  description = "Database password"
  type        = string
  default     = ""
}

variable "config_secret_PRIM_ADMIN_PASS" {
  description = "Primary admin password"
  type        = string
  default     = "your-pwd"
}

variable "config_secret_PRIM_JWT_SECRET" {
  description = "Primary JWT secret"
  type        = string
  default     = "your-pwd-value"
}

variable "config_secret_OIDC_CLIENT_PWD" {
  description = "OIDC client password"
  type        = string
  default     = ""
}

variable "config_secret_INTERNAL_SECRET" {
  description = "Internal secret key"
  type        = string
  default     = "your-secret"
}


# This section of following variables are for kubernetes/deployments/configmap : dataloader_ui_config
variable "dl_ui_config_NODE_ENV" {
  description = "The environment the application is running in (e.g., production, development)."
  type        = string
  default     = "production"
}

variable "dl_ui_config_PORT" {
  description = "The port on which the application will run."
  type        = string
  default     = "3002"
}

variable "dl_ui_config_REACT_APP_DATALOADER_URL" {
  description = "The URL for the data loader service."
  type        = string
  default     = "https://dataloader.abotega.ca"
}

variable "dl_ui_config_REACT_APP_UI_URL_3EDGES" {
  description = "The URL for the 3edges UI."
  type        = string
  default     = "https://abotega.ca"
}

variable "dl_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME" {
  description = "The name of the access token cookie."
  type        = string
  default     = "_nid"
}

variable "dl_ui_config_REACT_APP_NONCE_COOKIE_NAME" {
  description = "The name of the nonce cookie."
  type        = string
  default     = "nnce"
}

variable "dl_ui_config_REACT_APP_PKEY_COOKIE_NAME" {
  description = "The name of the public key cookie."
  type        = string
  default     = "pkey"
}

variable "dl_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME" {
  description = "The name of the ID token cookie."
  type        = string
  default     = "primscookie"
}

variable "dl_ui_config_REACT_APP_OIDC_CLIENT_ID" {
  description = "The OIDC client ID for the application."
  type        = string
  default     = "3edgesUIClient"
}

variable "dl_ui_config_REACT_APP_OIDC_URL" {
  description = "The URL for the OIDC provider."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "dl_ui_config_REACT_APP_JWKS_URI" {
  description = "The URI for the JWKS endpoint."
  type        = string
  default     = "/jwks"
}

variable "dl_ui_config_REACT_APP_DOCUMENTATION_URL" {
  description = "The URL for the application documentation."
  type        = string
  default     = "https://docs.3edges.com/space/3edgesDoc/2226389009/Bulk+Data+import"
}

# This section of following variables are for kubernetes/deployments/secrets : dataloader_secrets
variable "dl_secret_dbPass" {
  description = "Database password for accessing the database."
  type        = string
  default     = ""
}

variable "dl_secret_OIDC_CLIENT_PWD" {
  description = "Password for OIDC client authentication."
  type        = string
  default     = "your-pwd"
}

# This section of following variables are for kubernetes/deployments/configmap : dataloader_config
variable "dl_config_NODE_ENV" {
  description = "The environment the application is running in, e.g., production, development."
  type        = string
  default     = "production"
}

variable "dl_config_CORS_ORIGIN" {
  description = "CORS origin settings to allow cross-origin requests."
  type        = string
  default     = "*"
}

variable "dl_config_PORT" {
  description = "Port number on which the application will run."
  type        = string
  default     = "3000"
}

variable "dl_config_NEO4J_POOL_SIZE" {
  description = "The size of the connection pool for Neo4j."
  type        = string
  default     = "300"
}

variable "dl_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS" {
  description = "Timeout for acquiring a connection from the Neo4j pool in milliseconds."
  type        = string
  default     = "60000"
}

variable "dl_config_NEO4J_MAX_CONNECTION_LIFETIME" {
  description = "Maximum lifetime of a Neo4j connection in milliseconds."
  type        = string
  default     = "3600000"
}

variable "dl_config_NEO4J_CONNECTION_TIMEOUT" {
  description = "Timeout for establishing a connection to Neo4j in milliseconds."
  type        = string
  default     = "30000"
}

variable "dl_config_dbName" {
  description = "Name of the Neo4j database."
  type        = string
  default     = "neo4j"
}

variable "dl_config_dbUser" {
  description = "Username for the Neo4j database."
  type        = string
  default     = "neo4j"
}

variable "dl_config_dbHost" {
  description = "Host URL for the Neo4j database."
  type        = string
  default     = "neo4j+s://ae61ebf7.databases.neo4j.io"
}

variable "dl_config_OIDC_URL" {
  description = "URL for the OpenID Connect provider."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "dl_config_OIDC_CLIENT_ID" {
  description = "Client ID for the OpenID Connect provider."
  type        = string
  default     = "3edgesDataloaderClient"
}

variable "dl_config_CONFIGURATION_URL" {
  description = "URL for application configuration."
  type        = string
  default     = "https://abotega.ca"
}

# This section of following variables are for kubernetes/deployments/configmap : cluster_config
variable "cluster_config_NODE_ENV" {
  description = "The environment in which the cluster is running (e.g., production, staging)."
  type        = string
  default     = "production"
}

variable "cluster_config_PORT" {
  description = "The port on which the service is running."
  type        = string
  default     = "3333"
}

variable "cluster_config_UI_URL" {
  description = "The URL for the user interface."
  type        = string
  default     = "https://abotega.ca"
}

variable "cluster_config_CLIENT_EMAIL" {
  description = "The client email address for service account authentication."
  type        = string
  default     = "911543339197-compute@developer.gserviceaccount.com"
}

variable "cluster_config_OIDC_URL" {
  description = "The OIDC provider URL."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "cluster_config_OIDC_CLIENT_ID" {
  description = "The OIDC client ID for authentication."
  type        = string
  default     = "3edgesConfigClient"
}

variable "cluster_config_config_CLUSTER" {
  description = "The name of the cluster."
  type        = string
  default     = "three-edges-cluster"
}

variable "cluster_config_config_LOCATION" {
  description = "The AWS region where the cluster is located."
  type        = string
  default     = "ca-west-1"
}

variable "cluster_config_NGINX_LB" {
  description = "The load balancer DNS name for NGINX."
  type        = string
  default     = "a716352115c504c3da290874d20eaab2-3e3aa36aacbd9350.elb.ca-west-1.amazonaws.com"
}

variable "cluster_config_DB_TYPE" {
  description = "The type of database used."
  type        = string
  default     = "neo4j"
}

variable "cluster_config_DB_VERSION" {
  description = "The version of the database."
  type        = string
  default     = "v5"
}

variable "cluster_config_DB_HOST" {
  description = "The host URL for the database."
  type        = string
  default     = "neo4j+s://ae61ebf7.databases.neo4j.io"
}

variable "cluster_config_DB_NAME" {
  description = "The name of the database."
  type        = string
  default     = "neo4j"
}

variable "cluster_config_DB_USER" {
  description = "The username for accessing the database."
  type        = string
  default     = "neo4j"
}

variable "cluster_config_CLUSTER_URL" {
  description = "The URL for the cluster management interface."
  type        = string
  default     = "https://cluster.abotega.ca"
}

variable "cluster_config_SEND_EMAIL_URL" {
  description = "The URL for the email sending service."
  type        = string
  default     = "https://edges-305901.uw.r.appspot.com/api"
}

variable "cluster_config_SEND_EMAIL_SERVER" {
  description = "The email server environment (e.g., PROD, DEV)."
  type        = string
  default     = "PROD"
}

variable "cluster_config_SEND_EMAIL_FROM" {
  description = "The email address from which emails are sent."
  type        = string
  default     = "noreply@abotega.ca"
}

variable "cluster_config_SEND_EMAIL_FROM_NAME" {
  description = "The name that appears in the 'from' field of sent emails."
  type        = string
  default     = "3Edges"
}

variable "cluster_config_PRIM_ADMIN_EMAIL" {
  description = "The email address of the primary administrator."
  type        = string
  default     = "3admin@abotega.ca"
}

# This section of following variables are for kubernetes/deployments/secrets : cluster_secret
variable "cluster_secret_OIDC_CLIENT_PWD" {
  description = "Password for the OIDC client."
  type        = string
  default     = "your-pwd"
}

variable "cluster_secret_DB_PASSWORD" {
  description = "Password for the database."
  type        = string
  default     = ""
}

variable "cluster_secret_PRIVATE_KEY" {
  description = "Private key for authentication."
  type        = string
  default = ""
}

variable "cluster_secret_CRON_PWD" {
  description = "Password for the cron jobs."
  type        = string
  default     = ""
}

variable "cluster_secret_SESSION_PIPELINE" {
  description = "Session ID for the pipeline."
  type        = string
  default     = ""
}

variable "cluster_secret_TOKEN_PIPELINE" {
  description = "Token for the pipeline."
  type        = string
  default     = "ccea8377-61b4-49aa-91f5-c312de02d5f3"
}

variable "cluster_secret_INTERNAL_SECRET" {
  description = "Internal secret key."
  type        = string
  default     = "your-secret"
}

# This section of following variables are for kubernetes/deployments/configmap : idp_config
variable "idp_config_NODE_ENV" {
  description = "The environment in which the application is running (e.g., production, development)."
  type        = string
  default     = "production"
}

variable "idp_config_OIDC_PORT" {
  description = "The port on which the OIDC server is listening."
  type        = string
  default     = "3001"
}

variable "idp_config_SERVER_HTTP_CORS_ORIGIN" {
  description = "CORS origin settings for the server."
  type        = string
  default     = "*"
}

variable "idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY" {
  description = "Strict Transport Security setting for the server."
  type        = string
  default     = "15552000"
}

variable "idp_config_SERVER_HTTP_X_FRAME_OPTIONS" {
  description = "X-Frame-Options setting for the server."
  type        = string
  default     = "sameorigin"
}

variable "idp_config_PRIM_ADMIN_EMAIL" {
  description = "Email address of the primary admin."
  type        = string
  default     = "3admin@abotega.ca"
}

variable "idp_config_CHECK_VERIFIED" {
  description = "Whether to check if users are verified."
  type        = string
  default     = "true"
}

variable "idp_config_NAMING_PROPERTY" {
  description = "The property used for naming in authentication queries."
  type        = string
  default     = "email"
}

variable "idp_config_SUBJECT_TYPE" {
  description = "The type of subject used in authentication queries."
  type        = string
  default     = "NiamUser"
}

variable "idp_config_AUTHN_QUERY" {
  description = "The authentication query for non-verified users."
  type        = string
  default     = "MATCH (user:$SUBJECT_TYPE) WHERE (user.$NAMING_PROPERTY = $username) OPTIONAL MATCH (user)-[rel: NIAM_BELONGS_TO | NIAM_ADMINISTERS]->(tenant:NiamTenant) WITH COLLECT(DISTINCT CASE WHEN user.email = '$PRIM_ADMIN_EMAIL' THEN 'Roles.SuperAdmin' WHEN type(rel) = 'NIAM_ADMINISTERS' THEN 'Roles.Admin' WHEN type(rel) = 'NIAM_BELONGS_TO' THEN 'Roles.User' END) as roles, user, '$SUBJECT_TYPE' as subtype RETURN user{ .*, roles, subtype }"
}

variable "idp_config_AUTHN_QUERY_VERIFIED" {
  description = "The authentication query for verified users."
  type        = string
  default     = "MATCH (user:$SUBJECT_TYPE) WHERE (user.$NAMING_PROPERTY = $username AND user.isVerified = true) OPTIONAL MATCH (user)-[rel: NIAM_BELONGS_TO | NIAM_ADMINISTERS]->(tenant:NiamTenant) WITH COLLECT(DISTINCT CASE WHEN user.email = '$PRIM_ADMIN_EMAIL' THEN 'Roles.SuperAdmin' WHEN type(rel) = 'NIAM_ADMINISTERS' THEN 'Roles.Admin' WHEN type(rel) = 'NIAM_BELONGS_TO' THEN 'Roles.User' END) as roles, user, '$SUBJECT_TYPE' as subtype RETURN user{ .*, roles, subtype }"
}

variable "idp_config_SOCIAL_URL" {
  description = "URL for social authentication."
  type        = string
  default     = "https://social.abotega.ca"
}

variable "idp_config_CLAIMS_ARRAY" {
  description = "Comma-separated list of claims to be included in the authentication token."
  type        = string
  default     = "_id,address,company,country,createDateTime,email,ip,isVerified,mobilePhone,name,roles,subtype,subscriptionLevel"
}

variable "idp_config_OIDC_ACCESS_TOKEN_EXPIRE" {
  description = "Expiration time of the OIDC access token in hours."
  type        = string
  default     = "24"
}

variable "idp_config_CONTENT_SECURITY_POLICY" {
  description = "Content Security Policy settings for the application."
  type        = string
  default     = "default-src 'self' https://abotega.ca https://abotega.ca/graphql https://idp.abotega.ca http://idp.abotega.ca https://3edges.com https://accounts.google.com https://www.google.com https://accounts.google.com/gsi/; frame-src 'self' https://www.google.com https://accounts.google.com/gsi/; base-uri 'self'; block-all-mixed-content; font-src 'self' https: data:; frame-ancestors 'self'; img-src 'self' data:; object-src 'none'; connect-src 'self' https://accounts.google.com/gsi/; script-src 'self' https://www.google.com https://accounts.google.com/gsi/client 'unsafe-inline'; script-src-elem 'self' https://accounts.google.com https://accounts.google.com/gsi/client 'unsafe-inline'; script-src-attr 'none'; style-src 'self' https://accounts.google.com/gsi/style https: 'unsafe-inline';"
}

variable "idp_config_ALLOW_HTTP_REDIRECTS" {
  description = "Whether to allow HTTP redirects."
  type        = string
  default     = "true"
}

variable "idp_config_PRIM_UI_URL" {
  description = "URL for the primary UI."
  type        = string
  default     = "https://abotega.ca"
}

variable "idp_config_OIDC_AUTHORIZE_ENDPOINT" {
  description = "OIDC authorization endpoint."
  type        = string
  default     = "/authorize"
}

variable "idp_config_OIDC_TOKEN_ENDPOINT" {
  description = "OIDC token endpoint."
  type        = string
  default     = "/token"
}

variable "idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT" {
  description = "OIDC token introspection endpoint."
  type        = string
  default     = "/token/introspection"
}

variable "idp_config_OIDC_ME_ENDPOINT" {
  description = "OIDC endpoint for user information."
  type        = string
  default     = "/me"
}

variable "idp_config_PROM_METRICS_PREFIX" {
  description = "Prefix for Prometheus metrics."
  type        = string
  default     = "ui_idp_"
}

variable "idp_config_PROM_ENABLE_DEFAULT_METRICS" {
  description = "Whether to enable default Prometheus metrics."
  type        = string
  default     = "false"
}

variable "idp_config_IS_IDP_PROXY" {
  description = "Whether the application is an IDP proxy."
  type        = string
  default     = "false"
}

variable "idp_config_OIDC_REGISTRATION_URI" {
  description = "OIDC registration URI."
  type        = string
  default     = "/reg"
}

variable "idp_config_NiamSvcAcc_Client_id" {
  description = "Niam service account client ID."
  type        = string
  default     = "NiamSvcAcctClient"
}

variable "idp_config_NiamSvcAcc_username" {
  description = "Niam service account username."
  type        = string
  default     = "NiamSvcAcct"
}

variable "idp_config_OIDC_URL" {
  description = "OIDC URL."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "idp_config_DB_TYPE" {
  description = "Database type."
  type        = string
  default     = "neo4j"
}

variable "idp_config_DB_VERSION" {
  description = "Database version."
  type        = string
  default     = "v5"
}

variable "idp_config_DB_HOST" {
  description = "Database host URL."
  type        = string
  default     = "neo4j+s://ae61ebf7.databases.neo4j.io"
}

variable "idp_config_DB_NAME" {
  description = "Database name."
  type        = string
  default     = "neo4j"
}

variable "idp_config_DB_USER" {
  description = "Database username."
  type        = string
  default     = "neo4j"
}

variable "idp_config_ACCESS_TOKEN_TYPE" {
  description = "Access token type."
  type        = string
  default     = "opaque"
}

variable "idp_config_CONSENT_PAGE" {
  description = "Whether to use a consent page."
  type        = string
  default     = "false"
}

variable "idp_config_OIDC_URL_3EDGES" {
  description = "OIDC URL for 3edges."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "idp_config_CLIENT_ID_3EDGES" {
  description = "Client ID for 3edges."
  type        = string
  default     = "3edgesConfigClient"
}

variable "idp_config_COOKIE_NNCE" {
  description = "Cookie name for nonce."
  type        = string
  default     = "nnce"
}

variable "idp_config_COOKIE_PRIMSCOOKIE" {
  description = "Cookie name for prims cookie."
  type        = string
  default     = "primscookie"
}

variable "idp_config_COOKIE_NID" {
  description = "Cookie name for NID."
  type        = string
  default     = "_nid"
}

variable "idp_config_COOKIE_PKEY" {
  description = "Cookie name for PKEY."
  type        = string
  default     = "pkey"
}

variable "idp_config_SOCIAL_GOOGLE_CLIENT_ID" {
  description = "Client ID for Google social authentication."
  type        = string
  default     = "911543339197-u736geahkepncd33u75f8kqqm4hk0250.apps.googleusercontent.com"
}

variable "idp_config_SOCIAL_GOOGLE_OIDC_URL" {
  description = "OIDC URL for Google social authentication."
  type        = string
  default     = "https://accounts.google.com"
}

variable "idp_config_SOCIAL_GOOGLE_JWKS_URI" {
  description = "JWKS URI for Google social authentication."
  type        = string
  default     = "https://www.googleapis.com/oauth2/v3/certs"
}

variable "idp_config_PRIM_UI_CLIENT_ID" {
  description = "Client ID for the primary UI."
  type        = string
  default     = "3edgesUIClient"
}

variable "idp_config_OIDC_REFRESH_TOKEN_EXPIRE" {
  description = "Expiration time of the OIDC refresh token in hours."
  type        = string
  default     = "24"
}

variable "idp_config_CONFIG_URL" {
  description = "URL for configuration."
  type        = string
  default     = "https://abotega.ca/graphql"
}

variable "idp_config_DB_RECORDS_BATCH_SIZE" {
  description = "Batch size for database records."
  type        = string
  default     = "100"
}

variable "idp_config_REDIS_HOST" {
  description = "Host for Redis."
  type        = string
  default     = "redis-headless"
}

variable "idp_config_REDIS_PORT" {
  description = "Port for Redis."
  type        = string
  default     = "6379"
}


# This section of following variables are for kubernetes/deployments/secrets : idp_secrets
variable "idp_secret_CLIENT_SECRET_ENC_KEY" {
  description = "Encryption key for client secret"
  type        = string
  default     = ""
}

variable "idp_secret_NiamSvcAcc_Client_secret" {
  description = "Client secret for Niam service account"
  type        = string
  default     = ""
}

variable "idp_secret_NiamSvcAcc_pwd" {
  description = "Password for Niam service account"
  type        = string
  default     = ""
}

variable "idp_secret_DB_PASSWORD" {
  description = "Password for database access"
  type        = string
  default     = ""
}

variable "idp_secret_CLIENT_PWD_3EDGES" {
  description = "Password for 3edges client"
  type        = string
  default     = "your-pwd"
}

variable "idp_secret_INTERNAL_SECRET" {
  description = "Internal secret key"
  type        = string
  default     = "your-secret"
}



# This section of following variables are for kubernetes/deployments/configmap : ui-config
variable "ui_config_NODE_ENV" {
  description = "The environment in which the application is running (e.g., production)."
  type        = string
  default     = "production"
}

variable "ui_config_PORT" {
  description = "The port on which the application will listen."
  type        = string
  default     = "3005"
}

variable "ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME" {
  description = "The name of the access token cookie used by the React application."
  type        = string
  default     = "_nid"
}

variable "ui_config_REACT_APP_NONCE_COOKIE_NAME" {
  description = "The name of the nonce cookie used by the React application."
  type        = string
  default     = "nnce"
}

variable "ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME" {
  description = "The name of the ID token cookie used by the React application."
  type        = string
  default     = "primscookie"
}

variable "ui_config_REACT_APP_PKEY_COOKIE_NAME" {
  description = "The name of the PKEY cookie used by the React application."
  type        = string
  default     = "pkey"
}

variable "ui_config_REACT_APP_ENABLE_SELFREGISTRATION" {
  description = "Whether self-registration is enabled in the React application."
  type        = string
  default     = "true"
}

variable "ui_config_REACT_APP_JWKS_URI" {
  description = "The URI for JWKS used by the React application."
  type        = string
  default     = "/jwks"
}

variable "ui_config_REACT_APP_OIDC_CLIENT_ID" {
  description = "The OIDC client ID used by the React application."
  type        = string
  default     = "3edgesUIClient"
}

variable "ui_config_REACT_APP_OIDC_AUTH_ENDPOINT" {
  description = "The OIDC authorization endpoint used by the React application."
  type        = string
  default     = "/authorize"
}

variable "ui_config_REACT_APP_URL_UI" {
  description = "The base URL of the UI for the React application."
  type        = string
  default     = "https://abotega.ca"
}

variable "ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT" {
  description = "The OIDC token endpoint used by the React application."
  type        = string
  default     = "/token"
}

variable "ui_config_REACT_APP_OIDC_URL" {
  description = "The base URL for the OIDC provider used by the React application."
  type        = string
  default     = "https://idp.abotega.ca/oidc"
}

variable "ui_config_REACT_APP_PRIM_BACKEND_URI" {
  description = "The URI of the backend used by the React application."
  type        = string
  default     = "https://abotega.ca/graphql"
}

variable "ui_config_REACT_APP_ENABLE_NEWCLUSTER" {
  description = "Whether the new cluster feature is enabled in the React application."
  type        = string
  default     = "false"
}

variable "ui_config_REACT_APP_config_PROXY" {
  description = "The proxy URL used for the application configuration."
  type        = string
  default     = "https://tmp-random-url.abotega.ca"
}

variable "ui_config_REACT_APP_NEWCLUSTER_PROXY" {
  description = "The proxy URL used for the new cluster feature."
  type        = string
  default     = "https://tmp-random-url.abotega.ca"
}

variable "ui_config_REACT_APP_config_IDP" {
  description = "The IDP URL used for application configuration."
  type        = string
  default     = "https://tmp-random-url.abotega.ca/oidc"
}

variable "ui_config_REACT_APP_NEWCLUSTER_IDP" {
  description = "The IDP URL used for the new cluster feature."
  type        = string
  default     = "https://tmp-random-url.abotega.ca/oidc"
}

variable "ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME" {
  description = "The name of the local storage item used for refresh tokens."
  type        = string
  default     = "default_nid_r"
}

variable "ui_config_REACT_APP_IDLE_TIME_IN_MINUTES" {
  description = "The idle time in minutes before the user is logged out."
  type        = string
  default     = "20"
}

variable "ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME" {
  description = "The name of the local storage item used for social provider data."
  type        = string
  default     = "socialProvider"
}

variable "ui_config_REACT_APP_WEBLOADER_URL" {
  description = "The URL for the web loader used by the React application."
  type        = string
  default     = "https://webloader.abotega.ca"
}



# This section of following variables are for kubernetes/deployments/secrets : ui_secrets
variable "ui_secret_REACT_APP_OIDC_CLIENT_PWD" {
  description = "The OIDC client password for the React application."
  type        = string
  default     = "your-pwd"
}

variable "ui_secret_REACT_APP_INTERNAL_SECRET" {
  description = "The internal secret for the React application."
  type        = string
  default     = "your-secret"
}

variable "ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE" {
  description = "The invisible reCAPTCHA V2 key for the React application."
  type        = string
  default     = "6LcmeBEbAAAAAO0GvPUCyIs9ow-LFUFiX6UQbU8m"
}

variable "ui_secret_REACT_APP_CAPTCHA_V2" {
  description = "The reCAPTCHA V2 key for the React application."
  type        = string
  default     = "6LdfFiIbAAAAABnGUFnN3e8unsXBYVvMorbBFR4U"
}
