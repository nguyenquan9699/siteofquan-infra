data "aws_acm_certificate" "siteofquan_cert" {
  domain = var.domain_name
}