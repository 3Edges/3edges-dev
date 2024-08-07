output "iam_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "iam_eks_policy" {
  value = aws_iam_role_policy_attachment.eks_policy.role
}

output "iam_eks_vpc_resource_controller_policy" {
  value = aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy.role
}

output "aws_iam_role" {
  value = aws_iam_role.eks_node_role.arn
}

output "eks_worker_node_policy" {
  value = aws_iam_role_policy_attachment.eks_worker_node_policy.role
}

output "eks_cni_policy" {
  value = aws_iam_role_policy_attachment.eks_cni_policy.role
}

output "ec2_container_registry_readonly" {
  value = aws_iam_role_policy_attachment.ec2_container_registry_readonly.role
}

output "route53_full_access" {
  value = aws_iam_role_policy_attachment.route53_full_access.role
}