
locals {
  api_name = var.manual_api_deployment ? module.client[0].api_name : "" 
}

locals {
  configuration_config_AUTHZ_CSP_SERVER_URL = "${local.api_name}-authz-csp.3edges.svc.cluster.local:5003"
}

locals {
    dataloader_ui_config_REACT_APP_CONTENT_SECURITY_POLICY = "default-src self *.${var.hosted_zone} https://dataloader.${var.hosted_zone} https://webloader.${var.hosted_zone} https://${var.hosted_zone} https://idp.${var.hosted_zone}; script-src self *.${var.hosted_zone} https://webloader.${var.hosted_zone} unsafe-inline; img-src self *.${var.hosted_zone} https://webloader.${var.hosted_zone} data:; style-src self https://fonts.googleapis.com *.${var.hosted_zone} https://webloader.${var.hosted_zone} unsafe-inline; font-src self https://fonts.gstatic.com;"
}

locals {
  ui_config_REACT_APP_3EDGES_PROXY = "https://tmp-random-url.${var.hosted_zone}"
}

locals {
  ui_config_REACT_APP_3EDGES_IDP = "https://tmp-random-url.${var.hosted_zone}/oidc"
}