resource "aws_route53_zone" "hosted_zone" {
  name = "${var.hosted_zone}."
}

resource "aws_route53_record" "route53_cname" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = "www.${var.hosted_zone}"
  type    = "CNAME"
  ttl     = 300
  records = [var.hosted_zone]
}
