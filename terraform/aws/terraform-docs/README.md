## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_cypher"></a> [cypher](#module\_cypher) | ./modules/cypher | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_kubernetes"></a> [kubernetes](#module\_kubernetes) | ./modules/kubernetes | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.configuration_config_secret_PRIM_JWT_SECRET](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.idp_secret_CLIENT_SECRET_ENC_KEY](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.idp_secret_NiamSvcAcc_Client_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.idp_secret_NiamSvcAcc_pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | The AWS access key ID for authentication. | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be deployed (e.g., us-east-1). | `string` | `""` | no |
| <a name="input_aws_secret_access_key"></a> [aws\_secret\_access\_key](#input\_aws\_secret\_access\_key) | The AWS secret access key for authentication. | `string` | `""` | no |
| <a name="input_cluster_config_CLIENT_EMAIL"></a> [cluster\_config\_CLIENT\_EMAIL](#input\_cluster\_config\_CLIENT\_EMAIL) | The client email address for service account authentication. | `string` | `"911543339197-compute@developer.gserviceaccount.com"` | no |
| <a name="input_cluster_config_CLUSTER_URL"></a> [cluster\_config\_CLUSTER\_URL](#input\_cluster\_config\_CLUSTER\_URL) | The URL for the cluster management interface. | `string` | `""` | no |
| <a name="input_cluster_config_NGINX_LB"></a> [cluster\_config\_NGINX\_LB](#input\_cluster\_config\_NGINX\_LB) | The load balancer DNS name for NGINX. | `string` | `""` | no |
| <a name="input_cluster_config_NODE_ENV"></a> [cluster\_config\_NODE\_ENV](#input\_cluster\_config\_NODE\_ENV) | The environment in which the cluster is running (e.g., production, staging). | `string` | `"production"` | no |
| <a name="input_cluster_config_OIDC_CLIENT_ID"></a> [cluster\_config\_OIDC\_CLIENT\_ID](#input\_cluster\_config\_OIDC\_CLIENT\_ID) | The OIDC client ID for authentication. | `string` | `"3edgesConfigClient"` | no |
| <a name="input_cluster_config_OIDC_URL"></a> [cluster\_config\_OIDC\_URL](#input\_cluster\_config\_OIDC\_URL) | The OIDC provider URL. | `string` | `""` | no |
| <a name="input_cluster_config_PORT"></a> [cluster\_config\_PORT](#input\_cluster\_config\_PORT) | The port on which the service is running. | `string` | `"3333"` | no |
| <a name="input_cluster_config_SEND_EMAIL_SERVER"></a> [cluster\_config\_SEND\_EMAIL\_SERVER](#input\_cluster\_config\_SEND\_EMAIL\_SERVER) | The email server environment (e.g., PROD, DEV). | `string` | `"PROD"` | no |
| <a name="input_cluster_config_SEND_EMAIL_URL"></a> [cluster\_config\_SEND\_EMAIL\_URL](#input\_cluster\_config\_SEND\_EMAIL\_URL) | The URL for the email sending service. | `string` | `"https://edges-305901.uw.r.appspot.com/api"` | no |
| <a name="input_cluster_config_UI_URL"></a> [cluster\_config\_UI\_URL](#input\_cluster\_config\_UI\_URL) | The URL for the user interface. | `string` | `""` | no |
| <a name="input_cluster_config_config_CLUSTER"></a> [cluster\_config\_config\_CLUSTER](#input\_cluster\_config\_config\_CLUSTER) | The name of the cluster. | `string` | n/a | yes |
| <a name="input_cluster_config_config_LOCATION"></a> [cluster\_config\_config\_LOCATION](#input\_cluster\_config\_config\_LOCATION) | The AWS region where the cluster is located. | `string` | `"ca-west-1"` | no |
| <a name="input_cluster_secret_CRON_PWD"></a> [cluster\_secret\_CRON\_PWD](#input\_cluster\_secret\_CRON\_PWD) | Password for the cron jobs. | `string` | `""` | no |
| <a name="input_cluster_secret_PRIVATE_KEY"></a> [cluster\_secret\_PRIVATE\_KEY](#input\_cluster\_secret\_PRIVATE\_KEY) | Private key for authentication. | `string` | `""` | no |
| <a name="input_cluster_secret_SESSION_PIPELINE"></a> [cluster\_secret\_SESSION\_PIPELINE](#input\_cluster\_secret\_SESSION\_PIPELINE) | Session ID for the pipeline. | `string` | `""` | no |
| <a name="input_cluster_secret_TOKEN_PIPELINE"></a> [cluster\_secret\_TOKEN\_PIPELINE](#input\_cluster\_secret\_TOKEN\_PIPELINE) | Token for the pipeline. | `string` | `""` | no |
| <a name="input_configuration_config_AUTHZ_POD_PORT"></a> [configuration\_config\_AUTHZ\_POD\_PORT](#input\_configuration\_config\_AUTHZ\_POD\_PORT) | Port of the authorization pod | `string` | `"5055"` | no |
| <a name="input_configuration_config_CLUSTER_URL"></a> [configuration\_config\_CLUSTER\_URL](#input\_configuration\_config\_CLUSTER\_URL) | URL of the cluster | `string` | `""` | no |
| <a name="input_configuration_config_COOKIE_NNCE"></a> [configuration\_config\_COOKIE\_NNCE](#input\_configuration\_config\_COOKIE\_NNCE) | Cookie name for NNCE | `string` | `"nnce"` | no |
| <a name="input_configuration_config_COOKIE_PKEY"></a> [configuration\_config\_COOKIE\_PKEY](#input\_configuration\_config\_COOKIE\_PKEY) | Cookie name for PKEY | `string` | `"pkey"` | no |
| <a name="input_configuration_config_COOKIE_PRIMSCOOKIE"></a> [configuration\_config\_COOKIE\_PRIMSCOOKIE](#input\_configuration\_config\_COOKIE\_PRIMSCOOKIE) | Cookie name for PRIMSCOOKIE | `string` | `"primscookie"` | no |
| <a name="input_configuration_config_COST_LIMIT_DEPTHCOSTFACTOR"></a> [configuration\_config\_COST\_LIMIT\_DEPTHCOSTFACTOR](#input\_configuration\_config\_COST\_LIMIT\_DEPTHCOSTFACTOR) | Depth cost factor | `string` | `"2"` | no |
| <a name="input_configuration_config_COST_LIMIT_ENABLED"></a> [configuration\_config\_COST\_LIMIT\_ENABLED](#input\_configuration\_config\_COST\_LIMIT\_ENABLED) | Whether cost limiting is enabled | `string` | `"true"` | no |
| <a name="input_configuration_config_COST_LIMIT_IGNOREINTROSPECTION"></a> [configuration\_config\_COST\_LIMIT\_IGNOREINTROSPECTION](#input\_configuration\_config\_COST\_LIMIT\_IGNOREINTROSPECTION) | Whether to ignore introspection for cost limit | `string` | `"true"` | no |
| <a name="input_configuration_config_COST_LIMIT_MAXCOST"></a> [configuration\_config\_COST\_LIMIT\_MAXCOST](#input\_configuration\_config\_COST\_LIMIT\_MAXCOST) | Maximum cost limit | `string` | `"300000"` | no |
| <a name="input_configuration_config_COST_LIMIT_N"></a> [configuration\_config\_COST\_LIMIT\_N](#input\_configuration\_config\_COST\_LIMIT\_N) | Cost limit N | `string` | `"20"` | no |
| <a name="input_configuration_config_COST_LIMIT_OBJECTCOST"></a> [configuration\_config\_COST\_LIMIT\_OBJECTCOST](#input\_configuration\_config\_COST\_LIMIT\_OBJECTCOST) | Object cost limit | `string` | `"5"` | no |
| <a name="input_configuration_config_COST_LIMIT_SCALARCOST"></a> [configuration\_config\_COST\_LIMIT\_SCALARCOST](#input\_configuration\_config\_COST\_LIMIT\_SCALARCOST) | Scalar cost limit | `string` | `"5"` | no |
| <a name="input_configuration_config_DASHBOARD_POD_PORT"></a> [configuration\_config\_DASHBOARD\_POD\_PORT](#input\_configuration\_config\_DASHBOARD\_POD\_PORT) | Port of the dashboard pod | `string` | `"3045"` | no |
| <a name="input_configuration_config_DB_RECORDS_BATCH_SIZE"></a> [configuration\_config\_DB\_RECORDS\_BATCH\_SIZE](#input\_configuration\_config\_DB\_RECORDS\_BATCH\_SIZE) | Batch size for database records | `string` | `"10"` | no |
| <a name="input_configuration_config_DEFAULT_CONTENT_SECURITY_POLICY"></a> [configuration\_config\_DEFAULT\_CONTENT\_SECURITY\_POLICY](#input\_configuration\_config\_DEFAULT\_CONTENT\_SECURITY\_POLICY) | Default Content Security Policy | `string` | `""` | no |
| <a name="input_configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD"></a> [configuration\_config\_DEFAULT\_CONTENT\_SECURITY\_POLICY\_API\_DASHBOARD](#input\_configuration\_config\_DEFAULT\_CONTENT\_SECURITY\_POLICY\_API\_DASHBOARD) | Default Content Security Policy for API Dashboard | `string` | `""` | no |
| <a name="input_configuration_config_ENABLE_INTROSPECTION"></a> [configuration\_config\_ENABLE\_INTROSPECTION](#input\_configuration\_config\_ENABLE\_INTROSPECTION) | Whether to enable GraphQL introspection | `string` | `"true"` | no |
| <a name="input_configuration_config_ENABLE_PLAYGROUND"></a> [configuration\_config\_ENABLE\_PLAYGROUND](#input\_configuration\_config\_ENABLE\_PLAYGROUND) | Whether to enable GraphQL playground | `string` | `"true"` | no |
| <a name="input_configuration_config_IDP_POD_PORT"></a> [configuration\_config\_IDP\_POD\_PORT](#input\_configuration\_config\_IDP\_POD\_PORT) | Port of the IDP pod | `string` | `"3007"` | no |
| <a name="input_configuration_config_LOCALHOST_PROXY_AUTHORIZATION_URL"></a> [configuration\_config\_LOCALHOST\_PROXY\_AUTHORIZATION\_URL](#input\_configuration\_config\_LOCALHOST\_PROXY\_AUTHORIZATION\_URL) | Localhost proxy authorization URL | `string` | `""` | no |
| <a name="input_configuration_config_LOCALHOST_PROXY_DASHBOARD_URL"></a> [configuration\_config\_LOCALHOST\_PROXY\_DASHBOARD\_URL](#input\_configuration\_config\_LOCALHOST\_PROXY\_DASHBOARD\_URL) | Localhost proxy dashboard URL | `string` | `""` | no |
| <a name="input_configuration_config_LOCALHOST_PROXY_IDP_URL"></a> [configuration\_config\_LOCALHOST\_PROXY\_IDP\_URL](#input\_configuration\_config\_LOCALHOST\_PROXY\_IDP\_URL) | Localhost proxy IDP URL | `string` | `""` | no |
| <a name="input_configuration_config_MAX_ALIASES_ENABLED"></a> [configuration\_config\_MAX\_ALIASES\_ENABLED](#input\_configuration\_config\_MAX\_ALIASES\_ENABLED) | Whether max aliases is enabled | `string` | `"true"` | no |
| <a name="input_configuration_config_MAX_ALIASES_N"></a> [configuration\_config\_MAX\_ALIASES\_N](#input\_configuration\_config\_MAX\_ALIASES\_N) | Maximum number of aliases | `string` | `"20"` | no |
| <a name="input_configuration_config_MAX_CHARACTERS_N"></a> [configuration\_config\_MAX\_CHARACTERS\_N](#input\_configuration\_config\_MAX\_CHARACTERS\_N) | Maximum number of characters | `string` | `"15000"` | no |
| <a name="input_configuration_config_MAX_DEPTH_N"></a> [configuration\_config\_MAX\_DEPTH\_N](#input\_configuration\_config\_MAX\_DEPTH\_N) | Maximum depth N | `string` | `"8"` | no |
| <a name="input_configuration_config_MAX_DIRECTIVES_N"></a> [configuration\_config\_MAX\_DIRECTIVES\_N](#input\_configuration\_config\_MAX\_DIRECTIVES\_N) | Maximum number of directives | `string` | `"20"` | no |
| <a name="input_configuration_config_MAX_REDEPLOY"></a> [configuration\_config\_MAX\_REDEPLOY](#input\_configuration\_config\_MAX\_REDEPLOY) | Maximum redeploy count | `string` | `"5"` | no |
| <a name="input_configuration_config_MAX_SHUTDOWN"></a> [configuration\_config\_MAX\_SHUTDOWN](#input\_configuration\_config\_MAX\_SHUTDOWN) | Maximum shutdown time | `string` | `"20"` | no |
| <a name="input_configuration_config_MAX_TOKENS_N"></a> [configuration\_config\_MAX\_TOKENS\_N](#input\_configuration\_config\_MAX\_TOKENS\_N) | Maximum number of tokens | `string` | `"250"` | no |
| <a name="input_configuration_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS"></a> [configuration\_config\_NEO4J\_CONNECTION\_ACQUISITION\_TIMEOUT\_MS](#input\_configuration\_config\_NEO4J\_CONNECTION\_ACQUISITION\_TIMEOUT\_MS) | Neo4j connection acquisition timeout in milliseconds | `string` | `"60000"` | no |
| <a name="input_configuration_config_NEO4J_CONNECTION_TIMEOUT"></a> [configuration\_config\_NEO4J\_CONNECTION\_TIMEOUT](#input\_configuration\_config\_NEO4J\_CONNECTION\_TIMEOUT) | Neo4j connection timeout in milliseconds | `string` | `"30000"` | no |
| <a name="input_configuration_config_NEO4J_MAX_CONNECTION_LIFETIME"></a> [configuration\_config\_NEO4J\_MAX\_CONNECTION\_LIFETIME](#input\_configuration\_config\_NEO4J\_MAX\_CONNECTION\_LIFETIME) | Neo4j maximum connection lifetime in milliseconds | `string` | `"3600000"` | no |
| <a name="input_configuration_config_NEO4J_POOL_SIZE"></a> [configuration\_config\_NEO4J\_POOL\_SIZE](#input\_configuration\_config\_NEO4J\_POOL\_SIZE) | Neo4j connection pool size | `string` | `"300"` | no |
| <a name="input_configuration_config_NEO4J_URL_TEST"></a> [configuration\_config\_NEO4J\_URL\_TEST](#input\_configuration\_config\_NEO4J\_URL\_TEST) | URL of the Neo4j test database | `string` | `""` | no |
| <a name="input_configuration_config_NODE_ENV"></a> [configuration\_config\_NODE\_ENV](#input\_configuration\_config\_NODE\_ENV) | The environment in which the application is running | `string` | `"production"` | no |
| <a name="input_configuration_config_OIDC_CLIENT_ID"></a> [configuration\_config\_OIDC\_CLIENT\_ID](#input\_configuration\_config\_OIDC\_CLIENT\_ID) | OIDC client ID | `string` | `"3edgesConfigClient"` | no |
| <a name="input_configuration_config_OIDC_URL"></a> [configuration\_config\_OIDC\_URL](#input\_configuration\_config\_OIDC\_URL) | OIDC URL | `string` | `""` | no |
| <a name="input_configuration_config_PRIM_CONFIG_NEO4J_DB_TEST"></a> [configuration\_config\_PRIM\_CONFIG\_NEO4J\_DB\_TEST](#input\_configuration\_config\_PRIM\_CONFIG\_NEO4J\_DB\_TEST) | Neo4j test database name | `string` | `""` | no |
| <a name="input_configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN"></a> [configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_DEFAULT\_ORIGIN](#input\_configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_DEFAULT\_ORIGIN) | Default CORS origin for the primary server | `string` | `""` | no |
| <a name="input_configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN"></a> [configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_ORIGIN](#input\_configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_ORIGIN) | CORS origin for the primary server | `string` | `""` | no |
| <a name="input_configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP"></a> [configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_ORIGIN\_IDP](#input\_configuration\_config\_PRIM\_SERVER\_HTTP\_CORS\_ORIGIN\_IDP) | CORS origin for the IDP server | `string` | `""` | no |
| <a name="input_configuration_config_PROCESS_TIMEOUT_N"></a> [configuration\_config\_PROCESS\_TIMEOUT\_N](#input\_configuration\_config\_PROCESS\_TIMEOUT\_N) | Process timeout | `string` | `"10000"` | no |
| <a name="input_configuration_config_PROXY_POD_PORT"></a> [configuration\_config\_PROXY\_POD\_PORT](#input\_configuration\_config\_PROXY\_POD\_PORT) | Port of the proxy pod | `string` | `"4044"` | no |
| <a name="input_configuration_config_QUERY_COMPLEXITY_LIMIT"></a> [configuration\_config\_QUERY\_COMPLEXITY\_LIMIT](#input\_configuration\_config\_QUERY\_COMPLEXITY\_LIMIT) | Limit for query complexity | `string` | `"140000"` | no |
| <a name="input_configuration_config_REACT_APP_OTP_VALIDITY"></a> [configuration\_config\_REACT\_APP\_OTP\_VALIDITY](#input\_configuration\_config\_REACT\_APP\_OTP\_VALIDITY) | OTP validity period in minutes | `string` | `"2880"` | no |
| <a name="input_configuration_config_REDIS_HOST"></a> [configuration\_config\_REDIS\_HOST](#input\_configuration\_config\_REDIS\_HOST) | Host of the Redis server | `string` | `"redis-headless"` | no |
| <a name="input_configuration_config_REDIS_PORT"></a> [configuration\_config\_REDIS\_PORT](#input\_configuration\_config\_REDIS\_PORT) | Port of the Redis server | `string` | `"6379"` | no |
| <a name="input_configuration_config_REDIS_TIMEOUT_GET_APISERVER_STATUS"></a> [configuration\_config\_REDIS\_TIMEOUT\_GET\_APISERVER\_STATUS](#input\_configuration\_config\_REDIS\_TIMEOUT\_GET\_APISERVER\_STATUS) | Timeout for getting API server status in seconds | `string` | `"30"` | no |
| <a name="input_configuration_config_RESET_ADMIN_USER"></a> [configuration\_config\_RESET\_ADMIN\_USER](#input\_configuration\_config\_RESET\_ADMIN\_USER) | Whether to reset the admin user | `string` | `"true"` | no |
| <a name="input_configuration_config_SEND_EMAIL_SERVER"></a> [configuration\_config\_SEND\_EMAIL\_SERVER](#input\_configuration\_config\_SEND\_EMAIL\_SERVER) | Email server environment | `string` | `"PROD"` | no |
| <a name="input_configuration_config_SEND_EMAIL_URL"></a> [configuration\_config\_SEND\_EMAIL\_URL](#input\_configuration\_config\_SEND\_EMAIL\_URL) | URL used for sending emails | `string` | `"https://edges-305901.uw.r.appspot.com/api"` | no |
| <a name="input_configuration_config_SERVER_PORT"></a> [configuration\_config\_SERVER\_PORT](#input\_configuration\_config\_SERVER\_PORT) | The port on which the server listens | `string` | `"4005"` | no |
| <a name="input_configuration_config_UI_PROCESS_TIMEOUT_N"></a> [configuration\_config\_UI\_PROCESS\_TIMEOUT\_N](#input\_configuration\_config\_UI\_PROCESS\_TIMEOUT\_N) | UI process timeout | `string` | `"100000"` | no |
| <a name="input_configuration_config_UI_URL"></a> [configuration\_config\_UI\_URL](#input\_configuration\_config\_UI\_URL) | URL for the UI | `string` | `""` | no |
| <a name="input_configuration_config_secret_NEO4J_PASSWORD_TEST"></a> [configuration\_config\_secret\_NEO4J\_PASSWORD\_TEST](#input\_configuration\_config\_secret\_NEO4J\_PASSWORD\_TEST) | Neo4j password for the test environment | `string` | `""` | no |
| <a name="input_configuration_config_secret_PRIM_ADMIN_PASS"></a> [configuration\_config\_secret\_PRIM\_ADMIN\_PASS](#input\_configuration\_config\_secret\_PRIM\_ADMIN\_PASS) | Primary admin password | `string` | n/a | yes |
| <a name="input_configuration_config_secret_PRIM_JWT_SECRET"></a> [configuration\_config\_secret\_PRIM\_JWT\_SECRET](#input\_configuration\_config\_secret\_PRIM\_JWT\_SECRET) | Primary JWT secret | `string` | `""` | no |
| <a name="input_configuration_config_secret_SESSION_PIPELINE"></a> [configuration\_config\_secret\_SESSION\_PIPELINE](#input\_configuration\_config\_secret\_SESSION\_PIPELINE) | Session pipeline secret | `string` | `""` | no |
| <a name="input_configuration_config_secret_TOKEN_PIPELINE"></a> [configuration\_config\_secret\_TOKEN\_PIPELINE](#input\_configuration\_config\_secret\_TOKEN\_PIPELINE) | Token pipeline secret | `string` | `""` | no |
| <a name="input_dataloader_config_CONFIGURATION_URL"></a> [dataloader\_config\_CONFIGURATION\_URL](#input\_dataloader\_config\_CONFIGURATION\_URL) | URL for application configuration. | `string` | `""` | no |
| <a name="input_dataloader_config_CORS_ORIGIN"></a> [dataloader\_config\_CORS\_ORIGIN](#input\_dataloader\_config\_CORS\_ORIGIN) | CORS origin settings to allow cross-origin requests. | `string` | `"*"` | no |
| <a name="input_dataloader_config_NEO4J_CONNECTION_ACQUISITION_TIMEOUT_MS"></a> [dataloader\_config\_NEO4J\_CONNECTION\_ACQUISITION\_TIMEOUT\_MS](#input\_dataloader\_config\_NEO4J\_CONNECTION\_ACQUISITION\_TIMEOUT\_MS) | Timeout for acquiring a connection from the Neo4j pool in milliseconds. | `string` | `"60000"` | no |
| <a name="input_dataloader_config_NEO4J_CONNECTION_TIMEOUT"></a> [dataloader\_config\_NEO4J\_CONNECTION\_TIMEOUT](#input\_dataloader\_config\_NEO4J\_CONNECTION\_TIMEOUT) | Timeout for establishing a connection to Neo4j in milliseconds. | `string` | `"30000"` | no |
| <a name="input_dataloader_config_NEO4J_MAX_CONNECTION_LIFETIME"></a> [dataloader\_config\_NEO4J\_MAX\_CONNECTION\_LIFETIME](#input\_dataloader\_config\_NEO4J\_MAX\_CONNECTION\_LIFETIME) | Maximum lifetime of a Neo4j connection in milliseconds. | `string` | `"3600000"` | no |
| <a name="input_dataloader_config_NEO4J_POOL_SIZE"></a> [dataloader\_config\_NEO4J\_POOL\_SIZE](#input\_dataloader\_config\_NEO4J\_POOL\_SIZE) | The size of the connection pool for Neo4j. | `string` | `"300"` | no |
| <a name="input_dataloader_config_NODE_ENV"></a> [dataloader\_config\_NODE\_ENV](#input\_dataloader\_config\_NODE\_ENV) | The environment the application is running in, e.g., production, development. | `string` | `"production"` | no |
| <a name="input_dataloader_config_OIDC_CLIENT_ID"></a> [dataloader\_config\_OIDC\_CLIENT\_ID](#input\_dataloader\_config\_OIDC\_CLIENT\_ID) | Client ID for the OpenID Connect provider. | `string` | `"3edgesDataloaderClient"` | no |
| <a name="input_dataloader_config_OIDC_URL"></a> [dataloader\_config\_OIDC\_URL](#input\_dataloader\_config\_OIDC\_URL) | URL for the OpenID Connect provider. | `string` | `""` | no |
| <a name="input_dataloader_config_PORT"></a> [dataloader\_config\_PORT](#input\_dataloader\_config\_PORT) | Port number on which the application will run. | `string` | `"3000"` | no |
| <a name="input_dataloader_ui_config_NODE_ENV"></a> [dataloader\_ui\_config\_NODE\_ENV](#input\_dataloader\_ui\_config\_NODE\_ENV) | The environment the application is running in (e.g., production, development). | `string` | `"production"` | no |
| <a name="input_dataloader_ui_config_PORT"></a> [dataloader\_ui\_config\_PORT](#input\_dataloader\_ui\_config\_PORT) | The port on which the application will run. | `string` | `"3002"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME"></a> [dataloader\_ui\_config\_REACT\_APP\_ACCESS\_TOKEN\_COOKIE\_NAME](#input\_dataloader\_ui\_config\_REACT\_APP\_ACCESS\_TOKEN\_COOKIE\_NAME) | The name of the access token cookie. | `string` | `"_nid"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_DATALOADER_URL"></a> [dataloader\_ui\_config\_REACT\_APP\_DATALOADER\_URL](#input\_dataloader\_ui\_config\_REACT\_APP\_DATALOADER\_URL) | The URL for the data loader service. | `string` | `""` | no |
| <a name="input_dataloader_ui_config_REACT_APP_DOCUMENTATION_URL"></a> [dataloader\_ui\_config\_REACT\_APP\_DOCUMENTATION\_URL](#input\_dataloader\_ui\_config\_REACT\_APP\_DOCUMENTATION\_URL) | The URL for the application documentation. | `string` | `"https://docs.3edges.com/space/3edgesDoc/2226389009/Bulk+Data+import"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME"></a> [dataloader\_ui\_config\_REACT\_APP\_ID\_TOKEN\_COOKIE\_NAME](#input\_dataloader\_ui\_config\_REACT\_APP\_ID\_TOKEN\_COOKIE\_NAME) | The name of the ID token cookie. | `string` | `"primscookie"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_JWKS_URI"></a> [dataloader\_ui\_config\_REACT\_APP\_JWKS\_URI](#input\_dataloader\_ui\_config\_REACT\_APP\_JWKS\_URI) | The URI for the JWKS endpoint. | `string` | `"/jwks"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_NONCE_COOKIE_NAME"></a> [dataloader\_ui\_config\_REACT\_APP\_NONCE\_COOKIE\_NAME](#input\_dataloader\_ui\_config\_REACT\_APP\_NONCE\_COOKIE\_NAME) | The name of the nonce cookie. | `string` | `"nnce"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_OIDC_CLIENT_ID"></a> [dataloader\_ui\_config\_REACT\_APP\_OIDC\_CLIENT\_ID](#input\_dataloader\_ui\_config\_REACT\_APP\_OIDC\_CLIENT\_ID) | The OIDC client ID for the application. | `string` | `"3edgesUIClient"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_OIDC_URL"></a> [dataloader\_ui\_config\_REACT\_APP\_OIDC\_URL](#input\_dataloader\_ui\_config\_REACT\_APP\_OIDC\_URL) | The URL for the OIDC provider. | `string` | `""` | no |
| <a name="input_dataloader_ui_config_REACT_APP_PKEY_COOKIE_NAME"></a> [dataloader\_ui\_config\_REACT\_APP\_PKEY\_COOKIE\_NAME](#input\_dataloader\_ui\_config\_REACT\_APP\_PKEY\_COOKIE\_NAME) | The name of the public key cookie. | `string` | `"pkey"` | no |
| <a name="input_dataloader_ui_config_REACT_APP_UI_URL_3EDGES"></a> [dataloader\_ui\_config\_REACT\_APP\_UI\_URL\_3EDGES](#input\_dataloader\_ui\_config\_REACT\_APP\_UI\_URL\_3EDGES) | The URL for the 3edges UI. | `string` | `""` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | The name of the EKS cluster to be used. | `string` | `"three-edges-cluster"` | no |
| <a name="input_eks_internet_gateway"></a> [eks\_internet\_gateway](#input\_eks\_internet\_gateway) | The internet gateway associated with the EKS cluster. | `string` | `"three-edges-eks-igw"` | no |
| <a name="input_eks_node_group"></a> [eks\_node\_group](#input\_eks\_node\_group) | The name of the EKS node group. | `string` | `"three-edges-node-group"` | no |
| <a name="input_eks_node_role"></a> [eks\_node\_role](#input\_eks\_node\_role) | The IAM role for the EKS node group. | `string` | `"three-edges-eks-node-role"` | no |
| <a name="input_eks_role"></a> [eks\_role](#input\_eks\_role) | The IAM role associated with the EKS cluster. | `string` | `"three-edges-eks-role"` | no |
| <a name="input_eks_route_table"></a> [eks\_route\_table](#input\_eks\_route\_table) | The route table associated with the EKS cluster. | `string` | `"three-edges-eks-route-table"` | no |
| <a name="input_eks_security_group"></a> [eks\_security\_group](#input\_eks\_security\_group) | The security group associated with the EKS cluster. | `string` | `"three-edges-eks-security-group"` | no |
| <a name="input_eks_vpc"></a> [eks\_vpc](#input\_eks\_vpc) | The VPC associated with the EKS cluster. | `string` | `"three-edges-eks-vpc"` | no |
| <a name="input_exclude_certificate"></a> [exclude\_certificate](#input\_exclude\_certificate) | Flag to exclude the creation of certificates (true/false). | `bool` | `false` | no |
| <a name="input_exclude_cluster_issuer"></a> [exclude\_cluster\_issuer](#input\_exclude\_cluster\_issuer) | Flag to exclude the creation of the ClusterIssuer for cert-manager (true/false). | `bool` | `false` | no |
| <a name="input_hosted_zone"></a> [hosted\_zone](#input\_hosted\_zone) | The Route 53 hosted zone ID for DNS management. | `string` | `""` | no |
| <a name="input_idp_config_ACCESS_TOKEN_TYPE"></a> [idp\_config\_ACCESS\_TOKEN\_TYPE](#input\_idp\_config\_ACCESS\_TOKEN\_TYPE) | Access token type. | `string` | `"opaque"` | no |
| <a name="input_idp_config_ALLOW_HTTP_REDIRECTS"></a> [idp\_config\_ALLOW\_HTTP\_REDIRECTS](#input\_idp\_config\_ALLOW\_HTTP\_REDIRECTS) | Whether to allow HTTP redirects. | `string` | `"true"` | no |
| <a name="input_idp_config_AUTHN_QUERY"></a> [idp\_config\_AUTHN\_QUERY](#input\_idp\_config\_AUTHN\_QUERY) | The authentication query for non-verified users. | `string` | `"MATCH (user:$SUBJECT_TYPE) WHERE (user.$NAMING_PROPERTY = $username) OPTIONAL MATCH (user)-[rel: NIAM_BELONGS_TO | NIAM_ADMINISTERS]->(tenant:NiamTenant) WITH COLLECT(DISTINCT CASE WHEN user.email = '$PRIM_ADMIN_EMAIL' THEN 'Roles.SuperAdmin' WHEN type(rel) = 'NIAM_ADMINISTERS' THEN 'Roles.Admin' WHEN type(rel) = 'NIAM_BELONGS_TO' THEN 'Roles.User' END) as roles, user, '$SUBJECT_TYPE' as subtype RETURN user{ .*, roles, subtype }"` | no |
| <a name="input_idp_config_AUTHN_QUERY_VERIFIED"></a> [idp\_config\_AUTHN\_QUERY\_VERIFIED](#input\_idp\_config\_AUTHN\_QUERY\_VERIFIED) | The authentication query for verified users. | `string` | `"MATCH (user:$SUBJECT_TYPE) WHERE (user.$NAMING_PROPERTY = $username AND user.isVerified = true) OPTIONAL MATCH (user)-[rel: NIAM_BELONGS_TO | NIAM_ADMINISTERS]->(tenant:NiamTenant) WITH COLLECT(DISTINCT CASE WHEN user.email = '$PRIM_ADMIN_EMAIL' THEN 'Roles.SuperAdmin' WHEN type(rel) = 'NIAM_ADMINISTERS' THEN 'Roles.Admin' WHEN type(rel) = 'NIAM_BELONGS_TO' THEN 'Roles.User' END) as roles, user, '$SUBJECT_TYPE' as subtype RETURN user{ .*, roles, subtype }"` | no |
| <a name="input_idp_config_CHECK_VERIFIED"></a> [idp\_config\_CHECK\_VERIFIED](#input\_idp\_config\_CHECK\_VERIFIED) | Whether to check if users are verified. | `string` | `"true"` | no |
| <a name="input_idp_config_CLAIMS_ARRAY"></a> [idp\_config\_CLAIMS\_ARRAY](#input\_idp\_config\_CLAIMS\_ARRAY) | Comma-separated list of claims to be included in the authentication token. | `string` | `"_id,address,company,country,createDateTime,email,ip,isVerified,mobilePhone,name,roles,subtype,subscriptionLevel"` | no |
| <a name="input_idp_config_CLIENT_ID_3EDGES"></a> [idp\_config\_CLIENT\_ID\_3EDGES](#input\_idp\_config\_CLIENT\_ID\_3EDGES) | Client ID for 3edges. | `string` | `"3edgesConfigClient"` | no |
| <a name="input_idp_config_CONFIG_URL"></a> [idp\_config\_CONFIG\_URL](#input\_idp\_config\_CONFIG\_URL) | URL for configuration. | `string` | `""` | no |
| <a name="input_idp_config_CONSENT_PAGE"></a> [idp\_config\_CONSENT\_PAGE](#input\_idp\_config\_CONSENT\_PAGE) | Whether to use a consent page. | `string` | `"false"` | no |
| <a name="input_idp_config_CONTENT_SECURITY_POLICY"></a> [idp\_config\_CONTENT\_SECURITY\_POLICY](#input\_idp\_config\_CONTENT\_SECURITY\_POLICY) | Content Security Policy settings for the application. | `string` | `""` | no |
| <a name="input_idp_config_COOKIE_NID"></a> [idp\_config\_COOKIE\_NID](#input\_idp\_config\_COOKIE\_NID) | Cookie name for NID. | `string` | `"_nid"` | no |
| <a name="input_idp_config_COOKIE_NNCE"></a> [idp\_config\_COOKIE\_NNCE](#input\_idp\_config\_COOKIE\_NNCE) | Cookie name for nonce. | `string` | `"nnce"` | no |
| <a name="input_idp_config_COOKIE_PKEY"></a> [idp\_config\_COOKIE\_PKEY](#input\_idp\_config\_COOKIE\_PKEY) | Cookie name for PKEY. | `string` | `"pkey"` | no |
| <a name="input_idp_config_COOKIE_PRIMSCOOKIE"></a> [idp\_config\_COOKIE\_PRIMSCOOKIE](#input\_idp\_config\_COOKIE\_PRIMSCOOKIE) | Cookie name for prims cookie. | `string` | `"primscookie"` | no |
| <a name="input_idp_config_DB_RECORDS_BATCH_SIZE"></a> [idp\_config\_DB\_RECORDS\_BATCH\_SIZE](#input\_idp\_config\_DB\_RECORDS\_BATCH\_SIZE) | Batch size for database records. | `string` | `"100"` | no |
| <a name="input_idp_config_IS_IDP_PROXY"></a> [idp\_config\_IS\_IDP\_PROXY](#input\_idp\_config\_IS\_IDP\_PROXY) | Whether the application is an IDP proxy. | `string` | `"false"` | no |
| <a name="input_idp_config_NAMING_PROPERTY"></a> [idp\_config\_NAMING\_PROPERTY](#input\_idp\_config\_NAMING\_PROPERTY) | The property used for naming in authentication queries. | `string` | `"email"` | no |
| <a name="input_idp_config_NODE_ENV"></a> [idp\_config\_NODE\_ENV](#input\_idp\_config\_NODE\_ENV) | The environment in which the application is running (e.g., production, development). | `string` | `"production"` | no |
| <a name="input_idp_config_NiamSvcAcc_Client_id"></a> [idp\_config\_NiamSvcAcc\_Client\_id](#input\_idp\_config\_NiamSvcAcc\_Client\_id) | Niam service account client ID. | `string` | `"NiamSvcAcctClient"` | no |
| <a name="input_idp_config_NiamSvcAcc_username"></a> [idp\_config\_NiamSvcAcc\_username](#input\_idp\_config\_NiamSvcAcc\_username) | Niam service account username. | `string` | `"NiamSvcAcct"` | no |
| <a name="input_idp_config_OIDC_ACCESS_TOKEN_EXPIRE"></a> [idp\_config\_OIDC\_ACCESS\_TOKEN\_EXPIRE](#input\_idp\_config\_OIDC\_ACCESS\_TOKEN\_EXPIRE) | Expiration time of the OIDC access token in hours. | `string` | `"24"` | no |
| <a name="input_idp_config_OIDC_AUTHORIZE_ENDPOINT"></a> [idp\_config\_OIDC\_AUTHORIZE\_ENDPOINT](#input\_idp\_config\_OIDC\_AUTHORIZE\_ENDPOINT) | OIDC authorization endpoint. | `string` | `"/authorize"` | no |
| <a name="input_idp_config_OIDC_ME_ENDPOINT"></a> [idp\_config\_OIDC\_ME\_ENDPOINT](#input\_idp\_config\_OIDC\_ME\_ENDPOINT) | OIDC endpoint for user information. | `string` | `"/me"` | no |
| <a name="input_idp_config_OIDC_PORT"></a> [idp\_config\_OIDC\_PORT](#input\_idp\_config\_OIDC\_PORT) | The port on which the OIDC server is listening. | `string` | `"3007"` | no |
| <a name="input_idp_config_OIDC_REFRESH_TOKEN_EXPIRE"></a> [idp\_config\_OIDC\_REFRESH\_TOKEN\_EXPIRE](#input\_idp\_config\_OIDC\_REFRESH\_TOKEN\_EXPIRE) | Expiration time of the OIDC refresh token in hours. | `string` | `"24"` | no |
| <a name="input_idp_config_OIDC_REGISTRATION_URI"></a> [idp\_config\_OIDC\_REGISTRATION\_URI](#input\_idp\_config\_OIDC\_REGISTRATION\_URI) | OIDC registration URI. | `string` | `"/reg"` | no |
| <a name="input_idp_config_OIDC_TOKEN_ENDPOINT"></a> [idp\_config\_OIDC\_TOKEN\_ENDPOINT](#input\_idp\_config\_OIDC\_TOKEN\_ENDPOINT) | OIDC token endpoint. | `string` | `"/token"` | no |
| <a name="input_idp_config_OIDC_TOKEN_INTROSPECTION_ENDPOINT"></a> [idp\_config\_OIDC\_TOKEN\_INTROSPECTION\_ENDPOINT](#input\_idp\_config\_OIDC\_TOKEN\_INTROSPECTION\_ENDPOINT) | OIDC token introspection endpoint. | `string` | `"/token/introspection"` | no |
| <a name="input_idp_config_OIDC_URL"></a> [idp\_config\_OIDC\_URL](#input\_idp\_config\_OIDC\_URL) | OIDC URL. | `string` | `""` | no |
| <a name="input_idp_config_OIDC_URL_3EDGES"></a> [idp\_config\_OIDC\_URL\_3EDGES](#input\_idp\_config\_OIDC\_URL\_3EDGES) | OIDC URL for 3edges. | `string` | `""` | no |
| <a name="input_idp_config_PRIM_UI_CLIENT_ID"></a> [idp\_config\_PRIM\_UI\_CLIENT\_ID](#input\_idp\_config\_PRIM\_UI\_CLIENT\_ID) | Client ID for the primary UI. | `string` | `"3edgesUIClient"` | no |
| <a name="input_idp_config_PRIM_UI_URL"></a> [idp\_config\_PRIM\_UI\_URL](#input\_idp\_config\_PRIM\_UI\_URL) | URL for the primary UI. | `string` | `""` | no |
| <a name="input_idp_config_PROM_ENABLE_DEFAULT_METRICS"></a> [idp\_config\_PROM\_ENABLE\_DEFAULT\_METRICS](#input\_idp\_config\_PROM\_ENABLE\_DEFAULT\_METRICS) | Whether to enable default Prometheus metrics. | `string` | `"false"` | no |
| <a name="input_idp_config_PROM_METRICS_PREFIX"></a> [idp\_config\_PROM\_METRICS\_PREFIX](#input\_idp\_config\_PROM\_METRICS\_PREFIX) | Prefix for Prometheus metrics. | `string` | `"ui_idp_"` | no |
| <a name="input_idp_config_REDIS_HOST"></a> [idp\_config\_REDIS\_HOST](#input\_idp\_config\_REDIS\_HOST) | Host for Redis. | `string` | `"redis-headless"` | no |
| <a name="input_idp_config_REDIS_PORT"></a> [idp\_config\_REDIS\_PORT](#input\_idp\_config\_REDIS\_PORT) | Port for Redis. | `string` | `"6379"` | no |
| <a name="input_idp_config_SERVER_HTTP_CORS_ORIGIN"></a> [idp\_config\_SERVER\_HTTP\_CORS\_ORIGIN](#input\_idp\_config\_SERVER\_HTTP\_CORS\_ORIGIN) | CORS origin settings for the server. | `string` | `"*"` | no |
| <a name="input_idp_config_SERVER_HTTP_STRICT_TRANSPORT_SECURITY"></a> [idp\_config\_SERVER\_HTTP\_STRICT\_TRANSPORT\_SECURITY](#input\_idp\_config\_SERVER\_HTTP\_STRICT\_TRANSPORT\_SECURITY) | Strict Transport Security setting for the server. | `string` | `"15552000"` | no |
| <a name="input_idp_config_SERVER_HTTP_X_FRAME_OPTIONS"></a> [idp\_config\_SERVER\_HTTP\_X\_FRAME\_OPTIONS](#input\_idp\_config\_SERVER\_HTTP\_X\_FRAME\_OPTIONS) | X-Frame-Options setting for the server. | `string` | `"sameorigin"` | no |
| <a name="input_idp_config_SOCIAL_GOOGLE_CLIENT_ID"></a> [idp\_config\_SOCIAL\_GOOGLE\_CLIENT\_ID](#input\_idp\_config\_SOCIAL\_GOOGLE\_CLIENT\_ID) | Client ID for Google social authentication. | `string` | `"911543339197-u736geahkepncd33u75f8kqqm4hk0250.apps.googleusercontent.com"` | no |
| <a name="input_idp_config_SOCIAL_GOOGLE_JWKS_URI"></a> [idp\_config\_SOCIAL\_GOOGLE\_JWKS\_URI](#input\_idp\_config\_SOCIAL\_GOOGLE\_JWKS\_URI) | JWKS URI for Google social authentication. | `string` | `"https://www.googleapis.com/oauth2/v3/certs"` | no |
| <a name="input_idp_config_SOCIAL_GOOGLE_OIDC_URL"></a> [idp\_config\_SOCIAL\_GOOGLE\_OIDC\_URL](#input\_idp\_config\_SOCIAL\_GOOGLE\_OIDC\_URL) | OIDC URL for Google social authentication. | `string` | `"https://accounts.google.com"` | no |
| <a name="input_idp_config_SOCIAL_URL"></a> [idp\_config\_SOCIAL\_URL](#input\_idp\_config\_SOCIAL\_URL) | URL for social authentication. | `string` | `""` | no |
| <a name="input_idp_config_SUBJECT_TYPE"></a> [idp\_config\_SUBJECT\_TYPE](#input\_idp\_config\_SUBJECT\_TYPE) | The type of subject used in authentication queries. | `string` | `"NiamUser"` | no |
| <a name="input_idp_secret_CLIENT_SECRET_ENC_KEY"></a> [idp\_secret\_CLIENT\_SECRET\_ENC\_KEY](#input\_idp\_secret\_CLIENT\_SECRET\_ENC\_KEY) | Encryption key for client secret | `string` | `""` | no |
| <a name="input_idp_secret_NiamSvcAcc_Client_secret"></a> [idp\_secret\_NiamSvcAcc\_Client\_secret](#input\_idp\_secret\_NiamSvcAcc\_Client\_secret) | Client secret for Niam service account | `string` | `""` | no |
| <a name="input_idp_secret_NiamSvcAcc_pwd"></a> [idp\_secret\_NiamSvcAcc\_pwd](#input\_idp\_secret\_NiamSvcAcc\_pwd) | Password for Niam service account | `string` | `""` | no |
| <a name="input_shared_config_PRIM_ADMIN_EMAIL"></a> [shared\_config\_PRIM\_ADMIN\_EMAIL](#input\_shared\_config\_PRIM\_ADMIN\_EMAIL) | Primary admin email address | `string` | n/a | yes |
| <a name="input_shared_config_SEND_EMAIL_FROM"></a> [shared\_config\_SEND\_EMAIL\_FROM](#input\_shared\_config\_SEND\_EMAIL\_FROM) | Email address from which emails are sent | `string` | n/a | yes |
| <a name="input_shared_config_SEND_EMAIL_FROM_NAME"></a> [shared\_config\_SEND\_EMAIL\_FROM\_NAME](#input\_shared\_config\_SEND\_EMAIL\_FROM\_NAME) | Name displayed as the sender in emails | `string` | n/a | yes |
| <a name="input_shared_secret_INTERNAL_SECRET"></a> [shared\_secret\_INTERNAL\_SECRET](#input\_shared\_secret\_INTERNAL\_SECRET) | Internal secret key | `string` | `"MRDIuSYR6wqg0ha9"` | no |
| <a name="input_shared_secret_OIDC_CLIENT_PWD"></a> [shared\_secret\_OIDC\_CLIENT\_PWD](#input\_shared\_secret\_OIDC\_CLIENT\_PWD) | OIDC client password | `string` | `"g3ize7GxYFPT"` | no |
| <a name="input_three_edges_DB_HOST"></a> [three\_edges\_DB\_HOST](#input\_three\_edges\_DB\_HOST) | Host of the database | `string` | n/a | yes |
| <a name="input_three_edges_DB_NAME"></a> [three\_edges\_DB\_NAME](#input\_three\_edges\_DB\_NAME) | Name of the database | `string` | n/a | yes |
| <a name="input_three_edges_DB_TYPE"></a> [three\_edges\_DB\_TYPE](#input\_three\_edges\_DB\_TYPE) | Type of database used | `string` | n/a | yes |
| <a name="input_three_edges_DB_USER"></a> [three\_edges\_DB\_USER](#input\_three\_edges\_DB\_USER) | Database username | `string` | n/a | yes |
| <a name="input_three_edges_DB_VERSION"></a> [three\_edges\_DB\_VERSION](#input\_three\_edges\_DB\_VERSION) | Version of the database | `string` | n/a | yes |
| <a name="input_three_edges_secret_DB_PASSWORD"></a> [three\_edges\_secret\_DB\_PASSWORD](#input\_three\_edges\_secret\_DB\_PASSWORD) | Database password | `string` | n/a | yes |
| <a name="input_ui_config_NODE_ENV"></a> [ui\_config\_NODE\_ENV](#input\_ui\_config\_NODE\_ENV) | The environment in which the application is running (e.g., production). | `string` | `"production"` | no |
| <a name="input_ui_config_PORT"></a> [ui\_config\_PORT](#input\_ui\_config\_PORT) | The port on which the application will listen. | `string` | `"3005"` | no |
| <a name="input_ui_config_REACT_APP_ACCESS_TOKEN_COOKIE_NAME"></a> [ui\_config\_REACT\_APP\_ACCESS\_TOKEN\_COOKIE\_NAME](#input\_ui\_config\_REACT\_APP\_ACCESS\_TOKEN\_COOKIE\_NAME) | The name of the access token cookie used by the React application. | `string` | `"_nid"` | no |
| <a name="input_ui_config_REACT_APP_CONTENT_SECURITY_POLICY"></a> [ui\_config\_REACT\_APP\_CONTENT\_SECURITY\_POLICY](#input\_ui\_config\_REACT\_APP\_CONTENT\_SECURITY\_POLICY) | Content Security Policy settings for the application. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_ENABLE_NEWCLUSTER"></a> [ui\_config\_REACT\_APP\_ENABLE\_NEWCLUSTER](#input\_ui\_config\_REACT\_APP\_ENABLE\_NEWCLUSTER) | Whether the new cluster feature is enabled in the React application. | `string` | `"false"` | no |
| <a name="input_ui_config_REACT_APP_ENABLE_SELFREGISTRATION"></a> [ui\_config\_REACT\_APP\_ENABLE\_SELFREGISTRATION](#input\_ui\_config\_REACT\_APP\_ENABLE\_SELFREGISTRATION) | Whether self-registration is enabled in the React application. | `string` | `"true"` | no |
| <a name="input_ui_config_REACT_APP_IDLE_TIME_IN_MINUTES"></a> [ui\_config\_REACT\_APP\_IDLE\_TIME\_IN\_MINUTES](#input\_ui\_config\_REACT\_APP\_IDLE\_TIME\_IN\_MINUTES) | The idle time in minutes before the user is logged out. | `string` | `"20"` | no |
| <a name="input_ui_config_REACT_APP_ID_TOKEN_COOKIE_NAME"></a> [ui\_config\_REACT\_APP\_ID\_TOKEN\_COOKIE\_NAME](#input\_ui\_config\_REACT\_APP\_ID\_TOKEN\_COOKIE\_NAME) | The name of the ID token cookie used by the React application. | `string` | `"primscookie"` | no |
| <a name="input_ui_config_REACT_APP_JWKS_URI"></a> [ui\_config\_REACT\_APP\_JWKS\_URI](#input\_ui\_config\_REACT\_APP\_JWKS\_URI) | The URI for JWKS used by the React application. | `string` | `"/jwks"` | no |
| <a name="input_ui_config_REACT_APP_NEWCLUSTER_IDP"></a> [ui\_config\_REACT\_APP\_NEWCLUSTER\_IDP](#input\_ui\_config\_REACT\_APP\_NEWCLUSTER\_IDP) | The IDP URL used for the new cluster feature. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_NEWCLUSTER_PROXY"></a> [ui\_config\_REACT\_APP\_NEWCLUSTER\_PROXY](#input\_ui\_config\_REACT\_APP\_NEWCLUSTER\_PROXY) | The proxy URL used for the new cluster feature. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_NONCE_COOKIE_NAME"></a> [ui\_config\_REACT\_APP\_NONCE\_COOKIE\_NAME](#input\_ui\_config\_REACT\_APP\_NONCE\_COOKIE\_NAME) | The name of the nonce cookie used by the React application. | `string` | `"nnce"` | no |
| <a name="input_ui_config_REACT_APP_OIDC_AUTH_ENDPOINT"></a> [ui\_config\_REACT\_APP\_OIDC\_AUTH\_ENDPOINT](#input\_ui\_config\_REACT\_APP\_OIDC\_AUTH\_ENDPOINT) | The OIDC authorization endpoint used by the React application. | `string` | `"/authorize"` | no |
| <a name="input_ui_config_REACT_APP_OIDC_CLIENT_ID"></a> [ui\_config\_REACT\_APP\_OIDC\_CLIENT\_ID](#input\_ui\_config\_REACT\_APP\_OIDC\_CLIENT\_ID) | The OIDC client ID used by the React application. | `string` | `"3edgesUIClient"` | no |
| <a name="input_ui_config_REACT_APP_OIDC_TOKEN_ENDPOINT"></a> [ui\_config\_REACT\_APP\_OIDC\_TOKEN\_ENDPOINT](#input\_ui\_config\_REACT\_APP\_OIDC\_TOKEN\_ENDPOINT) | The OIDC token endpoint used by the React application. | `string` | `"/token"` | no |
| <a name="input_ui_config_REACT_APP_OIDC_URL"></a> [ui\_config\_REACT\_APP\_OIDC\_URL](#input\_ui\_config\_REACT\_APP\_OIDC\_URL) | The base URL for the OIDC provider used by the React application. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_PKEY_COOKIE_NAME"></a> [ui\_config\_REACT\_APP\_PKEY\_COOKIE\_NAME](#input\_ui\_config\_REACT\_APP\_PKEY\_COOKIE\_NAME) | The name of the PKEY cookie used by the React application. | `string` | `"pkey"` | no |
| <a name="input_ui_config_REACT_APP_PRIM_BACKEND_URI"></a> [ui\_config\_REACT\_APP\_PRIM\_BACKEND\_URI](#input\_ui\_config\_REACT\_APP\_PRIM\_BACKEND\_URI) | The URI of the backend used by the React application. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_REFRESH_TOKEN_LOCAL_STORAGE_NAME"></a> [ui\_config\_REACT\_APP\_REFRESH\_TOKEN\_LOCAL\_STORAGE\_NAME](#input\_ui\_config\_REACT\_APP\_REFRESH\_TOKEN\_LOCAL\_STORAGE\_NAME) | The name of the local storage item used for refresh tokens. | `string` | `"default_nid_r"` | no |
| <a name="input_ui_config_REACT_APP_SOCIAL_PROVIDER_LOCAL_STORAGE_NAME"></a> [ui\_config\_REACT\_APP\_SOCIAL\_PROVIDER\_LOCAL\_STORAGE\_NAME](#input\_ui\_config\_REACT\_APP\_SOCIAL\_PROVIDER\_LOCAL\_STORAGE\_NAME) | The name of the local storage item used for social provider data. | `string` | `"socialProvider"` | no |
| <a name="input_ui_config_REACT_APP_URL_UI"></a> [ui\_config\_REACT\_APP\_URL\_UI](#input\_ui\_config\_REACT\_APP\_URL\_UI) | The base URL of the UI for the React application. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_WEBLOADER_URL"></a> [ui\_config\_REACT\_APP\_WEBLOADER\_URL](#input\_ui\_config\_REACT\_APP\_WEBLOADER\_URL) | The URL for the web loader used by the React application. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_config_IDP"></a> [ui\_config\_REACT\_APP\_config\_IDP](#input\_ui\_config\_REACT\_APP\_config\_IDP) | The IDP URL used for application configuration. | `string` | `""` | no |
| <a name="input_ui_config_REACT_APP_config_PROXY"></a> [ui\_config\_REACT\_APP\_config\_PROXY](#input\_ui\_config\_REACT\_APP\_config\_PROXY) | The proxy URL used for the application configuration. | `string` | `""` | no |
| <a name="input_ui_secret_REACT_APP_CAPTCHA_V2"></a> [ui\_secret\_REACT\_APP\_CAPTCHA\_V2](#input\_ui\_secret\_REACT\_APP\_CAPTCHA\_V2) | The reCAPTCHA V2 key for the React application. | `string` | `"6LdfFiIbAAAAABnGUFnN3e8unsXBYVvMorbBFR4U"` | no |
| <a name="input_ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE"></a> [ui\_secret\_REACT\_APP\_CAPTCHA\_V2\_INVISIBLE](#input\_ui\_secret\_REACT\_APP\_CAPTCHA\_V2\_INVISIBLE) | The invisible reCAPTCHA V2 key for the React application. | `string` | `"6LcmeBEbAAAAAO0GvPUCyIs9ow-LFUFiX6UQbU8m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_config_NGINX_LB"></a> [cluster\_config\_NGINX\_LB](#output\_cluster\_config\_NGINX\_LB) | n/a |
| <a name="output_configuration_config_CLUSTER_URL"></a> [configuration\_config\_CLUSTER\_URL](#output\_configuration\_config\_CLUSTER\_URL) | local values |
| <a name="output_oidc_provider_audience"></a> [oidc\_provider\_audience](#output\_oidc\_provider\_audience) | n/a |
| <a name="output_oidc_provider_url"></a> [oidc\_provider\_url](#output\_oidc\_provider\_url) | n/a |
