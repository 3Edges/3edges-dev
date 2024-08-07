
provider "local" {}

resource "null_resource" "namespace_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/../../../yaml/namespace.yaml"
  }

  depends_on = [
    var.eks_cluster,
    var.eks_node_group
  ]
}

resource "null_resource" "nginx_ingress_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/../../../yaml/nginx-ingress.yaml"
  }

  depends_on = [
    var.eks_cluster,
    var.eks_node_group
  ]
}

resource "null_resource" "cert_manager_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/../../../yaml/cert-manager.yaml"
  }

  depends_on = [
    var.eks_cluster,
    var.eks_node_group
  ]
}

resource "null_resource" "certificate_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/../../../yaml/certificate.yaml"
  }

  depends_on = [
    var.eks_cluster,
    var.eks_node_group
  ]
}
