provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "cluster" {
  source = "./modules/cluster"
}

module "iam" {
  source = "./modules/iam"
}

module "local" {
  source = "./modules/local"
}

module "kubernetes" {
  source = "./modules/kubernetes"
}

resource "aws_route53_zone" "hosted_zone" {
  name = "${var.hosted_zone}."
}

resource "aws_route53_record" "route53_cname" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = "www.${var.hosted_zone}"
  type    = "CNAME"
  ttl     = 300
  records = ["ui.${var.hosted_zone}"]
}
