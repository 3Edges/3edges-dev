terraform {
  backend "s3" {
    bucket  = "REPLACE-WITH-YOUR-S3-BUCKET-NAME"
    key     = "network/terraform.tfstate"
    region  = "REPLACE-WITH-YOUR-S3-BUCKET-REGION"
    encrypt = true
  }
}
