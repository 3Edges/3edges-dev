locals {
  api_name = "api-${random_string.api_random_string.result}"
}

locals {
  PROM_METRICS_PREFIX = "api_${random_string.api_random_string.result}"
}



