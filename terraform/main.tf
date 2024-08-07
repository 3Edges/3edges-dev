provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.eks_vpc
  }
}

resource "aws_subnet" "eks_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = var.eks_internet_gateway
  }
}

resource "aws_route_table" "eks_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = var.eks_route_table
  }
}

resource "aws_route_table_association" "eks_route_table_assoc" {
  count          = 2
  subnet_id      = aws_subnet.eks_subnet[count.index].id
  route_table_id = aws_route_table.eks_route_table.id
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnet[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy
  ]
}

resource "aws_iam_role" "eks_role" {
  name = var.eks_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_node_group
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.eks_subnet[*].id

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_readonly,
    aws_iam_role_policy_attachment.route53_full_access
  ]
}

resource "aws_iam_role" "eks_node_role" {
  name = var.eks_node_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_readonly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "route53_full_access" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.eks_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.eks_security_group
  }
}

resource "aws_security_group_rule" "eks_inbound_rule" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.eks_security_group.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  token                  = data.aws_eks_cluster_auth.eks_auth.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = "arn:aws:iam::356300141247:role/gIDP_admin"
        username = "arn:aws:sts::356300141247:assumed-role/gIDP_admin/{{SessionName}}"
        groups = [
          "system:masters"
        ]
      },
      {
        rolearn  = var.arn_node_role
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:nodes"
        ]
      }
    ])
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.1-eksbuild.3"

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "kube-proxy"
  addon_version = "v1.30.0-eksbuild.3"

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "eks_pod_identity" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.0-eksbuild.1"

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "coredns"
  addon_version = "v1.11.1-eksbuild.9"

  depends_on = [aws_eks_cluster.eks_cluster]
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

# resource "aws_route53_record" "a_record" {
#   zone_id = data.aws_route53_zone.example.id
#   name    = "nlb.example.com"
#   type    = "A"
#   alias {
#     name                   = aws_lb.nlb.dns_name
#     zone_id                = aws_lb.nlb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "terraform_data" "nginx_ingress" {
#   provisioner "local-exec" {
#     command = <<EOT
#     kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml
#     EOT
#     environment = {
#       KUBECONFIG = "${aws_eks_cluster.eks_cluster.kubeconfig[0].config}"
#     }
#   }

#   depends_on = [aws_eks_cluster.eks_cluster]
# }

# resource "terraform_data" "cert_manager" {
#   provisioner "local-exec" {
#     command = <<EOT
#     kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.14.5/cert-manager.yaml
#     EOT

#     environment = {
#       KUBECONFIG = "${aws_eks_cluster.example.kubeconfig[0].config}"
#     }
#   }

#   depends_on = [aws_eks_cluster.example]
# }


# ADD-ons (Amazon VPC CNI, kube-proxy, Amazon EKS Pod Identity Agent, CoreDNS)

# Access (IAM access entries) needs to be (
#   arn:aws:iam::356300141247:role/eks-node-role,
#   arn:aws:iam::356300141247:role/gIDP_admin -> access policy: AmazonEKSClusterAdminPolicy
# )
