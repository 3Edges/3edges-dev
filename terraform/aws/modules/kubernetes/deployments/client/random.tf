# This file generates random values 

resource "random_string" "api_random_string" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Allow uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = false # Exclude numbers
}

resource "random_uuid" "proxy_uuid" {
}

resource "random_uuid" "authz_uuid" {
}

resource "random_uuid" "dashboard_uuid" {
}

resource "random_uuid" "idp_uuid" {
}

resource "random_uuid" "default_uuid" {
  count = 3
}

resource "random_uuid" "common_uuid" {
  count = 3
}

# secrets.tf/ENC_KEY
resource "random_id" "enc_key" {
    byte_length = 16 # Generates 16 bytes (32 characters in hex) 
}

# secrets.tf/AUTHZ_PWD
resource "random_string" "authz_pwd" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}


# secrets.tf/PROXY_PWD
resource "random_string" "proxy_pwd" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/NiamSvcAcct_secret
resource "random_string" "NiamSvcAcct_secret" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/NiamSvcAcctClient_secret
resource "random_string" "NiamSvcAcctClient_secret" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/CLIENT_PWD_3EDGES
resource "random_string" "client_pwd_three_edges" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/OIDC_CLIENT_PWD 
resource "random_string" "oidc_client_pwd" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/PRIM_JWT_SECRET
resource "random_string" "prim_jwt_secret" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = true  # Allow numbers
}

# secrets.tf/REACT_APP_OIDC_CLIENT_PWD
resource "random_string" "react_app_oidc_client_pwd" {
  length  = 10    # Length of the random string
  special = false # Exclude special characters
  upper   = false # Exclude uppercase letters
  lower   = true  # Allow lowercase letters
  numeric = false  #  exclude numbers
}
