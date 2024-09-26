# Store a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "three_edges_secret" {
  name = "three_edges_secret_${var.four_letter_random}"
  description = "Stores the secrets for 3Edges deployment"

  depends_on = [ local.n_client_secret ]
}

# Add the secret value to AWS Secrets Manager
resource "aws_secretsmanager_secret_version" "three_edges_secret_v1" {
  secret_id     = aws_secretsmanager_secret.three_edges_secret.id
  secret_string = jsonencode({
    "oidc_client_pwd" = "${var.shared_secret_OIDC_CLIENT_PWD}"
    "internal_secret" = "${var.shared_secret_INTERNAL_SECRET}"
    "n_client_secret" = "${local.n_client_secret}"
  })

  depends_on = [ local.n_client_secret ]
}