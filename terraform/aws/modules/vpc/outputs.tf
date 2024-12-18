output "eks_subnet" {
  value = tolist(aws_subnet.eks_subnet)
}

output "eks_security_group_id" {
  value = aws_security_group.eks_security_group.id
}