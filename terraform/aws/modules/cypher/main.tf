terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

data "http" "query_1" {
  url    = local.db_url
  method = "POST"

  request_headers = {
    Authorization = "Basic ${local.encoded_credentials}"
    Content-Type  = "application/json"
  }

  # MERGE (n:NiamLastReleaseDate {date: "1997-01-01T23:59:59.000Z"}) return n;
  request_body = jsonencode(
    {
      "statement" : "MERGE (n:NiamLastReleaseDate {date: $date}) RETURN n",
      "parameters" : {
        "date" : "1997-01-01T23:59:59.000Z"
      }
    }
  )
  depends_on = [ local.n_client_secret ]
}


data "http" "query_2" {
  url    = local.db_url
  method = "POST"

  request_headers = {
    Authorization = "Basic ${local.encoded_credentials}"
    Content-Type  = "application/json"
  }

  # CALL apoc.create.uuids(5) YIELD uuid WITH collect(uuid) AS uuids
  request_body = jsonencode(
    {

      "statement" = "CALL apoc.create.uuids(5) YIELD uuid WITH collect(uuid) AS uuids MERGE (client1:NiamClient {name: \"3edgesUIClient\"}) ON CREATE SET client1._id = uuids[0] MERGE (client2:NiamClient {name: \"3edgesConfigClient\"}) ON CREATE SET client2._id = uuids[1] MERGE (client3:NiamClient {name: \"3edgesDataproxyClient\"}) ON CREATE SET client3._id = uuids[2] MERGE (client4:NiamClient {name: \"3edgesDataloaderClient\"}) ON CREATE SET client4._id = uuids[3] MERGE (client5:NiamClient {name: \"3edgesDataproxyAuthzClient\"}) ON CREATE SET client5._id = uuids[4] WITH client1, client2, client3, client4, client5 MATCH (n:NiamClient) SET n.grant_types = [\"password\",\"implicit\",\"device_code\",\"social\",\"authorization_code\",\"client_credentials\",\"refresh_token\"], n.redirect_uris = [\"http://localhost:3005\", \"http://localhost:3005/code\",\"https://${var.hosted_zone}\", \"https://${var.hosted_zone}/code\", \"https://webloader.${var.hosted_zone}/code\"], n.post_logout_redirect_uris = [\"http://localhost:3005\",\"http://localhost:3005/login\", \"https://${var.hosted_zone}\", \"https://webloader.${var.hosted_zone}\", \"https://${var.hosted_zone}/login\", \"https://webloader.${var.hosted_zone}/login\"], n.response_types = [\"id_token\",\"code\",\"code id_token\"], n.token_endpoint_auth_method = \"client_secret_basic\", n.client_secret = \"${local.n_client_secret}\", n.client_id = n.name"

    }
  )

  depends_on = [data.http.query_1, local.n_client_secret, null_resource.run_docker_container, data.local_file.n_client_secret  ]
}


data "http" "query_3" {
  url    = local.db_url
  method = "POST"

  request_headers = {
    Authorization = "Basic ${local.encoded_credentials}"
    Content-Type  = "application/json"
  }

  # MERGE (n:SubscribtionLevel) SET n = { Throttling: 50000, isVPC: false, DataLoader: false, MaxDataPassthrough: 1, MaxUsers: 1, Support: "0", Uptime: 0, MaxAPI: 1, MaxOrgs: 0, name: "FREE", isCluster: false, isAuthZ: true } RETURN n;
  request_body = jsonencode(
    {
      "statement" : "MERGE (n:SubscribtionLevel {name:\"FREE\"}) SET n = { Throttling: 50000, isVPC: false, DataLoader: false, MaxDataPassthrough: 1, MaxUsers: 1, Support: \"0\", Uptime: 0, MaxAPI: 1, MaxOrgs: 0, name: \"FREE\", isCluster: false, isAuthZ: true } RETURN n;"
    }
  )

  depends_on = [data.http.query_1, data.http.query_2, local.n_client_secret]
}


data "http" "query_4" {
  url    = local.db_url
  method = "POST"

  request_headers = {
    Authorization = "Basic ${local.encoded_credentials}"
    Content-Type  = "application/json"
  }

  # MERGE (n:SubscribtionLevel) SET n = { Throttling: 50000, isVPC: false, DataLoader: true, MaxDataPassthrough: 5, MaxUsers: 99, Support: "Unlimited", Uptime: "8x5", MaxAPI: 4, MaxOrgs: 1, name: "PRO", isCluster: true, isAuthZ: true } RETURN n;
  request_body = jsonencode(
    {
      "statement" : "MERGE (n:SubscribtionLevel {name:\"PRO\"}) SET n = { Throttling: 50000, isVPC: false, DataLoader: true, MaxDataPassthrough: 5, MaxUsers: 99, Support: \"Unlimited\", Uptime: \"8x5\", MaxAPI: 4, MaxOrgs: 1, name: \"PRO\", isCluster: true, isAuthZ: true } RETURN n;"

    }
  )

  depends_on = [data.http.query_1, data.http.query_2, data.http.query_3, local.n_client_secret]
}


data "http" "query_5" {
  url    = local.db_url
  method = "POST"

  request_headers = {
    Authorization = "Basic ${local.encoded_credentials}"
    Content-Type  = "application/json"
  }

  #MERGE (n:SubscribtionLevel) SET n = { Throttling: 50000, isVPC: true, MaxDataPassthrough: "Unlimited", DataLoader: true, Uptime: 99.95, MaxUsers: "Unlimited", Support: "24x7", MaxOrgs: "Unlimited", MaxAPI: "Unlimited", name: "ENT", isCluster: true, isAuthZ: true } RETURN n;
  request_body = jsonencode(
    {
      "statement" : "MERGE (n:SubscribtionLevel {name:\"ENT\"}) SET n = { Throttling: 50000, isVPC: true, MaxDataPassthrough: \"Unlimited\", DataLoader: true, Uptime: 99.95, MaxUsers: \"Unlimited\", Support: \"24x7\", MaxOrgs: \"Unlimited\", MaxAPI: \"Unlimited\", name: \"ENT\", isCluster: true, isAuthZ: true } RETURN n;"
    }
  )

  depends_on = [data.http.query_1, data.http.query_2, data.http.query_3, data.http.query_4, local.n_client_secret]
}




