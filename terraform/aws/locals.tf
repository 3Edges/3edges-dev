# This file does processing of input received from the client
locals {
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN = "https://${var.hosted_zone}"
}

locals {
  configuration_config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN = "https://${var.hosted_zone}"
}

locals {
  configuration_config_CLUSTER_URL = "https://cluster.${var.hosted_zone}/api"
}

locals {
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = "default-src 'self' *.${var.hosted_zone} https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com; script-src 'self' http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' www.gstatic.com/recaptcha data:; font-src 'self' https://fonts.gstatic.com; frame-src 'self' *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com; style-src 'self' https://fonts.googleapis.com 'unsafe-inline';"
}

locals {
  configuration_config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP = "https://idp.${var.hosted_zone}"
}

locals {
  configuration_config_DEFAULT_CONTENT_SECURITY_POLICY = "default-src 'self' *.${var.hosted_zone} https://embeddable-sandbox.cdn.apollographql.com/ https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com https://apollo-server-landing-page.cdn.apollographql.com; script-src 'self' https://embeddable-sandbox.cdn.apollographql.com/ http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ https://apollo-server-landing-page.cdn.apollographql.com/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' https://apollo-server-landing-page.cdn.apollographql.com data:; frame-src 'self' https://sandbox.embed.apollographql.com/ *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com https://apollo-server-landing-page.cdn.apollographql.com; style-src 'self' https://fonts.googleapis.com https://apollo-server-landing-page.cdn.apollographql.com 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com https://apollo-server-landing-page.cdn.apollographql.com;"
}

locals {
  configuration_config_UI_URL = "https://${var.hosted_zone}"
}

locals {
  configuration_config_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  dataloader_ui_config_REACT_APP_DATALOADER_URL = "https://dataloader.${var.hosted_zone}"
}

locals {
  dataloader_ui_config_REACT_APP_UI_URL_3EDGES = "https://${var.hosted_zone}"
}

locals {
  dataloader_ui_config_REACT_APP_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  dataloader_config_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"

}

locals {
  dataloader_config_CONFIGURATION_URL = "https://${var.hosted_zone}"
}

locals {
  cluster_config_UI_URL = "https://${var.hosted_zone}"
}

locals {
  cluster_config_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  cluster_config_config_LOCATION = var.aws_region
}

locals {
  cluster_config_CLUSTER_URL = "https://cluster.${var.hosted_zone}"
}

locals {
  ui_config_REACT_APP_URL_UI = "https://${var.hosted_zone}"
}

locals {
  ui_config_REACT_APP_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  ui_config_REACT_APP_PRIM_BACKEND_URI = "https://${var.hosted_zone}/graphql"
}

locals {
  ui_config_REACT_APP_config_PROXY = "https://tmp-random-url.${var.hosted_zone}"
}

locals {
  ui_config_REACT_APP_CONTENT_SECURITY_POLICY = "default-src self *.${var.hosted_zone} https://${var.hosted_zone}/graphql https://ipv4.icanhazip.com https://api.ipify.com http://localhost:3005 http://localhost:3007 http://localhost:3001 http://localhost:4005 http://localhost:4044 https://ipv4.icanhazip.com https://api.ipify.com; script-src self unsafe-inline https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ unsafe-inline unsafe-eval; img-src self *.${var.hosted_zone} http://localhost:3005 www.gstatic.com/recaptcha data:; frame-src self *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com; style-src self https://fonts.googleapis.com *.${var.hosted_zone} http://localhost:3005 unsafe-inline; font-src self https://fonts.gstatic.com"
}

locals {
  ui_config_REACT_APP_NEWCLUSTER_PROXY = "https://tmp-random-url.${var.hosted_zone}"
}

locals {
  ui_config_REACT_APP_config_IDP = "https://tmp-random-url.${var.hosted_zone}/oidc"
}

locals {
  ui_config_REACT_APP_NEWCLUSTER_IDP = "https://tmp-random-url.${var.hosted_zone}/oidc"
}

locals {
  ui_config_REACT_APP_WEBLOADER_URL = "https://webloader.${var.hosted_zone}"
}

locals {
  idp_config_SOCIAL_URL = "https://social.${var.hosted_zone}"
}

locals {
  idp_config_CONTENT_SECURITY_POLICY = "default-src 'self' https://${var.hosted_zone} https://${var.hosted_zone}/graphql https://idp.${var.hosted_zone} http://idp.${var.hosted_zone} https://3edges.com https://accounts.google.com https://www.google.com https://accounts.google.com/gsi/; frame-src 'self' https://www.google.com https://accounts.google.com/gsi/; base-uri 'self'; block-all-mixed-content; font-src 'self' https: data:; frame-ancestors 'self'; img-src 'self' data:; object-src 'none'; connect-src 'self' https://accounts.google.com/gsi/; script-src 'self' https://www.google.com https://accounts.google.com/gsi/client 'unsafe-inline'; script-src-elem 'self' https://accounts.google.com https://accounts.google.com/gsi/client 'unsafe-inline'; script-src-attr 'none'; style-src 'self' https://accounts.google.com/gsi/style https: 'unsafe-inline';"
}

locals {
  idp_config_PRIM_UI_URL = "https://${var.hosted_zone}"
}

locals {
  idp_config_OIDC_URL = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  idp_config_OIDC_URL_3EDGES = "https://idp.${var.hosted_zone}/oidc"
}

locals {
  idp_config_CONFIG_URL = "https://${var.hosted_zone}/graphql"
}

