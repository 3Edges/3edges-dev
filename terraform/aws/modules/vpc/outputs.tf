output "eks_subnet" {
  value = tolist(aws_subnet.eks_subnet)
}

# output "vpc_id" {
#   value = aws_vpc.eks_vpc.id
# }

# # NLB Security Group ID 
# output "nlb_sg_id" {
#   value = aws_security_group.nlb_security_group.id
# }


output "eks_security_group_id" {
  value = aws_security_group.eks_security_group.id
}