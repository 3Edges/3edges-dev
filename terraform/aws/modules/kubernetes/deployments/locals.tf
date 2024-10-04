
locals {
  api_name = var.manual_api_deployment ? module.client[0].api_name : "" 
}