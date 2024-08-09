provider "aws" {
  region = var.aws_region
}

module "iam" {
  source        = "./modules/iam"
  eks_role      = var.eks_role
  eks_node_role = var.eks_node_role
}

module "vpc" {
  source               = "./modules/vpc"
  eks_vpc              = var.eks_vpc
  eks_internet_gateway = var.eks_internet_gateway
  eks_route_table      = var.eks_route_table
  eks_security_group   = var.eks_security_group
}

module "cluster" {
  source                                 = "./modules/cluster"
  eks_cluster                            = var.eks_cluster
  eks_node_group                         = var.eks_node_group
  eks_subnet                             = module.vpc.eks_subnet
  iam_role_arn                           = module.iam.iam_role_arn
  aws_iam_role                           = module.iam.aws_iam_role
  iam_eks_policy                         = module.iam.iam_eks_policy
  iam_eks_vpc_resource_controller_policy = module.iam.iam_eks_vpc_resource_controller_policy
  eks_worker_node_policy                 = module.iam.eks_worker_node_policy
  eks_cni_policy                         = module.iam.eks_cni_policy
  ec2_container_registry_readonly        = module.iam.ec2_container_registry_readonly
  route53_full_access                    = module.iam.route53_full_access
}

module "kubernetes" {
  source                            = "./modules/kubernetes"
  aws_eks_cluster_auth_token        = module.cluster.aws_eks_cluster_auth_token
  aws_eks_cluster_auth_endpoint     = module.cluster.aws_eks_cluster_auth_endpoint
  aws_eks_cluster_auth_certificate  = module.cluster.aws_eks_cluster_auth_certificate
  aws_route53_zone_hosted_zone_id   = module.route53.aws_route53_zone_hosted_zone_id
  aws_route53_zone_hosted_zone_name = module.route53.aws_route53_zone_hosted_zone_name
  arn_node_role                     = var.arn_node_role
  aws_region                        = var.aws_region
  hosted_zone                       = var.hosted_zone
}

module "route53" {
  source      = "./modules/route53"
  hosted_zone = var.hosted_zone
}

module "deployments" {
  source        = "./modules/kubernetes/deployments"
  k8s_namespace = module.kubernetes.k8s_namespace
  hosted_zone   = var.hosted_zone
  aws_region    = var.aws_region
}