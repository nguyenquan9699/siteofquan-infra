data "aws_route53_zone" "siteofquan_zone" {
  name = "siteofquan.click"
}

resource "aws_route53_record" "siteofquan_click_record" {
  zone_id = data.aws_route53_zone.siteofquan_zone.id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.FE_distribution.domain_name]
}