provider "local" {}

data "local_file" "namespace_yaml" {
  filename = "${path.module}/../../../yaml/namespace.yaml"
}

resource "kubernetes_manifest" "namespace_resource" {
  manifest = yamldecode(data.local_file.namespace_yaml.content)
}