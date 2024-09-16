locals {
  encoded_credentials = base64encode("${var.three_edges_DB_USER}:${var.three_edges_secret_DB_PASSWORD}")
}

locals {
  db_url = "https${replace(var.three_edges_DB_HOST, "neo4j+s", "")}/db/neo4j/query/v2"
}