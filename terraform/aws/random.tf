# This file is used to generated random values to secrets 

resource "random_password" "configuration_config_secret_PRIM_JWT_SECRET" {
  length  = 32
  special = true
}

# resource "random_password" "shared_secret_OIDC_CLIENT_PWD" {
#   length  = 16
#   special = true
# }

# resource "random_password" "shared_secret_INTERNAL_SECRET" {
#   length  = 20
#   special = true
# }

resource "random_password" "idp_secret_CLIENT_SECRET_ENC_KEY" {
  length  = 32
  special = false
}

resource "random_password" "idp_secret_NiamSvcAcc_Client_secret" {
  length  = 20
  special = true
}

resource "random_password" "idp_secret_NiamSvcAcc_pwd" {
  length  = 20
  special = true
}
