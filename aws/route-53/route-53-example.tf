resource "aws_route53_zone" "example-com" {
  name          = "example.com"
  comment       = "Example of route 53"
  force_destroy = false
}

resource "aws_route53_record" "assets-example-com" {
  zone_id = aws_route53_zone.example-com.zone_id
  name    = "assets.example.com"
  type    = "CNAME"

  records = ["987987897.cloudfront.net"]
  ttl     = "300"
}