output "aws_lb_nginx_load_balancer" {
  value = data.aws_lb.nginx_load_balancer
}

output "split_hostname_id" {
  value = local.split_hostname[1]
}
