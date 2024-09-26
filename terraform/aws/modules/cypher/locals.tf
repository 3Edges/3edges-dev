locals {
  encoded_credentials = base64encode("${var.three_edges_DB_USER}:${var.three_edges_secret_DB_PASSWORD}")
}

locals {
  db_url = "https${replace(var.three_edges_DB_HOST, "neo4j+s", "")}/db/neo4j/query/v2"
}

# Define a local variable to store formatted value of the secret
locals {
  n_client_secret = trimspace(data.local_file.n_client_secret.content)
}



locals {
  encoded_credentials_client = base64encode("neo4j:yJbBJuFy6aRJRssrg--Ecd6l_bBtEhsY0yeZrJteY54")
}

locals {
  db_url_client = "https${replace("neo4j+s://c54f8564.databases.neo4j.io", "neo4j+s", "")}/db/neo4j/query/v2"
}