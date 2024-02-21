data "aws_route53_zone" "siteofquan_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "siteofquan_click_record" {
  zone_id = data.aws_route53_zone.siteofquan_zone.id
  name    = var.domain_name
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.FE_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.FE_distribution.hosted_zone_id
  }
}