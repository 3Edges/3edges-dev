resource "null_resource" "run_docker_container" {
  provisioner "local-exec" {
    command = "docker run --rm -e OIDC_CLIENT_PWD=${var.shared_secret_OIDC_CLIENT_PWD} -e INTERNAL_SECRET=${var.shared_secret_INTERNAL_SECRET} iamprajwal007/crypt-encrypt:latest > modules/cypher/n_client_secret.txt"
  }

  # Using the timestamp to trigger re-run on every apply
  triggers = {
    run_timestamp = timestamp()
  }
}

# Local file to capture the Docker output
data "local_file" "n_client_secret" {
  depends_on = [null_resource.run_docker_container]
  filename   = "${path.module}/n_client_secret.txt"
}

# Delete the file after extracting the value using another local-exec provisioner
# resource "null_resource" "delete_file" {
#   depends_on = [data.local_file.n_client_secret]

#   provisioner "local-exec" {
#     command = "rm -f modules/cypher/n_client_secret.txt"
#   }
#     triggers = {
#     run_timestamp = timestamp()
#   }
# }






