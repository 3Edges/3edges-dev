output "eks_subnet" {
  value = tolist(aws_subnet.eks_subnet)
}
