resource "kubernetes_config_map" "json_config" {
  metadata {
    name      = "prim-${local.api_name}-configmap"
    namespace = "3edges"
  }

  data = merge({

     "dataproxy" = jsonencode({
      "VC_AUTH_URL" : "https://auth-qa.credivera.com/realms/credivera/protocol/openid-connect/token",
      "PAYLOAD_SIZE_LIMIT" : "1mb",
      "OIDC_PROVIDER_CLAIMS_MAPPING" : "{\"_id\":\"sub\",\"username\":\"email\"}",
      "prefix" : "proxy",
      "CACHE_DEFAULT_TIMEOUT_IN_MILLISECONDS" : "7200000",
      "MAX_TROTTLE_COST" : "10000",
      "clientNameGCP" : "${local.api_name}",
      "CLIENT_ID_3EDGES" : "3edges_${local.api_name}_ProxyClient",
      "SUBSCRIPTION_LVL" : "FREE",
      "VC_CLIENT_SECRET" : "",
      "enableSchemaPersistence" : true,
      "ENABLE_GRAPHQL_CACHE" : false,
      "DEFAULT_LIMIT" : "20",
      "PROM_METRICS_PREFIX" : "${local.PROM_METRICS_PREFIX}_proxy_",
      "OIDC_CLIENT_ID" : "apiServer_${local.api_name}_ProxyClient",
      "ENABLE_LOGIN_API" : true,
      "VC_CLIENT_ID" : "3edges",
      "SHOW_QUERY_COST_IN_LOG" : true,
      "ENABLE_INTROSPECTION" : true,
      "ENABLE_PLAYGROUND" : true,
      "PORT" : "4044",
      "NAME" : "${local.api_name}-proxy",
      "VC_ISSUER_URL" : "https://vc-qa.credivera.io/api/credentials/issue",
      "_id" : "${random_uuid.proxy_uuid.result}",
      "lastUpdate" : "2024-05-05"

    }),

    "authz" = jsonencode({
      "clientNameGCP" : "${local.api_name}",
      "CLIENT_ID_3EDGES" : "3edges_${local.api_name}_AuthzClient",
      "PORT" : "5055",
      "prefix" : "authz",
      "_id" : "${random_uuid.authz_uuid.result}",
      "SELF_REL_DEPTH" : 2,
      "PROM_METRICS_PREFIX" : "${local.PROM_METRICS_PREFIX}_authz_",
      "OIDC_CLIENT_ID" : "apiServer_${local.api_name}_AuthzClient",
      "NAME" : "${local.api_name}-authz",
      "lastUpdate" : "2024-05-05"

    }),

    "authz-csp" = jsonencode({
      "PORT" : "5003",
      "prefix" : "authz-csp",
      "_id" : "${random_uuid.authz_uuid.result}",
      "NAME" : "${local.api_name}-authz",
      "lastUpdate" : "2024-05-05",
      "DB_TYPE": "",
      "DB_VERSION":"",
      "DB_HOST": "",
      "DB_USER": "",
      "DB_NAME": "",
      "DB_PASSWORD": ""
    }),

    "dashboard" = jsonencode({
      "REACT_APP_OIDC_CLIENT_ID" : "sac_${local.api_name}",
      "REACT_APP_EXTERNAL_PROVIDER" : false,
      "REACT_APP_VC_CREDIVERA_AUTHORITY" : "did:web:ui.qa.${var.hosted_zone}",
      "prefix" : "dashboard",
      "REACT_APP_URL_UI" : "https://${local.api_name}-dashboard.${var.hosted_zone}",
      "REACT_APP_OIDC_AUTH_ENDPOINT" : "/authorize",
      "REACT_APP_AUTHZ_URL" : "https://${local.api_name}-authz.${var.hosted_zone}",
      "REACT_APP_PKEY_COOKIE_NAME" : "pkey-${local.api_name}",
      "REACT_APP_OIDC_TOKEN_ENDPOINT" : "/token",
      "clientNameGCP" : "${local.api_name}",
      "REACT_APP_CONTENT_SECURITY_POLICY" : "default-src 'self' wss://${local.api_name}.${var.hosted_zone} https://${local.api_name}.${var.hosted_zone} https://${local.api_name}.${var.hosted_zone} https://${local.api_name}.${var.hosted_zone}/graphql https://idp.${var.hosted_zone}/oidc https://${local.api_name}-idp.${var.hosted_zone}/oidc https://${local.api_name}-idp.${var.hosted_zone}/oidc https://${local.api_name}-idp.${var.hosted_zone}/oidc/clients https://${local.api_name}-idp.${var.hosted_zone}/oidc/token https://${local.api_name}-idp.${var.hosted_zone}/oidc/reg https://${local.api_name}-idp.${var.hosted_zone} https://${local.api_name}-authz.${var.hosted_zone} https://auth-qa.credivera.com https://vc-qa.credivera.io *.${var.hosted_zone} *.qa.${var.hosted_zone} https://${local.api_name}-dashboard.${var.hosted_zone} http://localhost:3007 http://localhost:4005 https://ipv4.icanhazip.com https://api.ipify.com; script-src 'self' *.${var.hosted_zone} *.qa.${var.hosted_zone} http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' *.${var.hosted_zone} *.qa.${var.hosted_zone} https://${local.api_name}-dashboard.${var.hosted_zone} www.gstatic.com/recaptcha data:; frame-src 'self' *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com; style-src 'self' https://fonts.googleapis.com *.${var.hosted_zone} *.qa.${var.hosted_zone} https://${local.api_name}-dashboard.${var.hosted_zone} 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com;",
      "REACT_APP_OIDC_URL" : "https://${local.api_name}-idp.${var.hosted_zone}/oidc",
      "REACT_APP_WEB_SOCKET" : "https://${local.api_name}.${var.hosted_zone}",
      "REACT_APP_VC_CREDIVERA_USE_PIN" : false,
      "REACT_APP_NONCE_COOKIE_NAME" : "nnce-${local.api_name}",
      "REACT_APP_SUBJECT_SECRET" : "password",
      "REACT_APP_NAMING_PROPERTY" : "username",
      "REACT_APP_ACCESS_TOKEN_COOKIE_NAME" : "_nid-${local.api_name}",
      "PORT" : "3045",
      "REACT_APP_OIDC_CLIENTS_ENDPOINT" : "/clients",
      "NAME" : "${local.api_name}-dashboard",
      "REACT_APP_DATAPROXY_URL" : "https://${local.api_name}.${var.hosted_zone}/graphql",
      "REACT_APP_SUBJECT_TYPE" : "User",
      "REACT_APP_OIDC_CONFIGURATION_ENDPOINT" : "/configuration",
      "REACT_APP_ID_TOKEN_COOKIE_NAME" : "primscookie-${local.api_name}",
      "REACT_APP_JWKS_URI" : "/jwks",
      "REACT_APP_OIDC_REGISTRATION_ENDPOINT" : "/reg",
      "_id" : "${random_uuid.dashboard_uuid.result}",
      "REACT_APP_CLIENT_NAME_GCP" : "${local.api_name}",
      "lastUpdate" : "2024-05-05"

    }),

    "idp" = jsonencode({
      "COOKIE_NNCE" : "nnce",
      "NiamSvcAcc_Client_id" : "sac_${local.api_name}",
      "CONSENT_PAGE" : false,
      "prefix" : "idp",
      "OIDC_REFRESH_TOKEN_EXPIRE" : "24",
      "COOKIE_PKEY" : "pkey",
      "NiamSvcAcc_username" : "sa_${local.api_name}",
      "SERVER_HTTP_STRICT_TRANSPORT_SECURITY" : "15552000",
      "SERVER_HTTP_CORS_ORIGIN" : "*",
      "clientNameGCP" : "${local.api_name}",
      "PRIM_ADMIN_EMAIL" : "var.shared_config_PRIM_ADMIN_EMAIL",
      "CLIENT_ID_3EDGES" : "3edges_${local.api_name}_ProxyClient",
      "AUTHN_QUERY" : "MATCH (user:$SUBJECT_TYPE) WHERE user.$NAMING_PROPERTY = $username WITH user, '$SUBJECT_TYPE' as subtype RETURN user{ .*, subtype }",
      "REDIS_PORT" : "6379",
      "OIDC_PORT" : "3001",
      "ALLOW_HTTP_REDIRECTS" : true,
      "CLIENT_ID_DATAPROXY" : "apiServer_${local.api_name}_ProxyClient",
      "PROM_METRICS_PREFIX" : "${local.PROM_METRICS_PREFIX}_idp_",
      "COOKIE_NID" : "_nid",
      "REDIS_HOST" : "localhost",
      "OIDC_ACCESS_TOKEN_EXPIRE" : "24",
      "COOKIE_PRIMSCOOKIE" : "primscookie",
      "PORT" : "3001",
      "CONTENT_SECURITY_POLICY" : "default-src 'self' https://${local.api_name}-dashboard.${var.hosted_zone} https://www.google.com https://accounts.google.com https://ui.qa.${var.hosted_zone} https://${var.hosted_zone} http://${local.api_name}-idp.${var.hosted_zone}/oidc https://${local.api_name}-idp.${var.hosted_zone}/oidc; frame-src 'self' https://www.google.com https://accounts.google.com; base-uri 'self'; block-all-mixed-content; font-src 'self' https: data:; frame-ancestors 'self'; img-src 'self' data:; object-src 'none'; script-src-elem 'self' https://accounts.google.com https://accounts.google.com/gsi/client; script-src 'self' https://accounts.google.com https://accounts.google.com/gsi/client 'unsafe-inline'; script-src-attr 'none'; style-src 'self' https: 'unsafe-inline';",
      "SERVER_HTTP_X_FRAME_OPTIONS" : "sameorigin",
      "COOKIE_PROXY_NAMING" : "-${local.api_name}",
      "NAME" : "${local.api_name}-idp",
      "IS_IDP_PROXY" : true,
      "CLAIMS_ARRAY" : "_id,username,subtype",
      "SOCIAL_URL" : "https://social.${var.hosted_zone}",
      "_id" : "${random_uuid.idp_uuid.result}",
      "username" : "",
      "lastUpdate" : "2024-05-05"


    }),




    "default" = jsonencode({
      "SEND_EMAIL_FROM" : "noreply@3edges.io",
      "DB_VERSION" : "",
      "apiKey" : "${random_uuid.common_uuid[0].result}${random_uuid.common_uuid[1].result}${random_uuid.common_uuid[2].result}",
      "OIDC_REGISTRATION_URI" : "/reg",
      "DB_USER" : "",
      "prefix" : "default",
      "SEND_EMAIL_SERVER" : "PROD",
      "DB_NAME" : "",
      "ENABLE_INTROSPECTION" : true,
      "NAMING_PROPERTY" : "username",
      "OIDC_URL_3EDGES" : "https://idp.${var.hosted_zone}/oidc",
      "clientNameGCP" : "${local.api_name}",
      "DATAPROXY_URL" : "https://${local.api_name}.${var.hosted_zone}",
      "DATAPROXY_GRAPHQL_URL" : "https://${local.api_name}.${var.hosted_zone}/graphql",
      "REDIS_PORT" : "6379",
      "OIDC_TOKEN_ENDPOINT" : "/token",
      "apiEnabled" : false,
      "OIDC_URL" : "https://${local.api_name}-idp.${var.hosted_zone}/oidc",
      "REDIS_HOST" : "redis-headless",
      "DASHBOARD_URL" : "https://${local.api_name}-dashboard.${var.hosted_zone}",
      "SUBJECT_SECRET" : "password",
      "OIDC_TOKEN_INTROSPECTION_ENDPOINT" : "/token/introspection",
      "SUBJECT_TYPE" : "User",
      "ENABLE_PLAYGROUND" : true,
      "PROM_ENABLE_DEFAULT_METRICS" : false,
      "OIDC_ME_ENDPOINT" : "/me",
      "superUserID" : "",
      "OIDC_JWKS_URI" : "/jwks",
      "SEND_EMAIL_FROM_NAME" : "3Edges",
      "DB_HOST" : "",
      "serverID" : "${random_uuid.default_uuid[0].result}",
      "AUTHZ_URL" : "https://${local.api_name}-authz.${var.hosted_zone}",
      "NAME" : "${local.api_name}-default",
      "OIDC_AUTHORIZE_ENDPOINT" : "/authorize",
      "DB_TYPE" : "",
      "ACCESS_TOKEN_TYPE" : "opaque",
      "_id" : "${random_uuid.default_uuid[1].result}",
      "EXTERNAL_PROVIDER" : false,
      "SEND_EMAIL_URL" : "https://edges-305901.uw.r.appspot.com/api",
      "REACT_APP_GRAPHQL_KEY" : "${random_uuid.common_uuid[0].result}${random_uuid.common_uuid[1].result}${random_uuid.common_uuid[2].result}",
      "REACT_APP_DB_NAME" : "",
      "REACT_APP_DB_HOST" : "",
      "REACT_APP_SERVER_ID" : "${random_uuid.default_uuid[2].result}"

    })


  })


  depends_on = [var.kubernetes_namespace_namespace]
}
