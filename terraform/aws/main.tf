provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}

module "cluster" {
  source                                 = "./modules/cluster"
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
}

module "route53" {
  source = "./modules/route53"
}

module "null_resource" {
  source         = "./modules/null_resource"
  eks_cluster    = module.cluster.aws_eks_cluster_eks_cluster
  eks_node_group = module.cluster.aws_eks_node_group_eks_node_group
}
