locals {
  s3_origin_id = "S3-${aws_s3_bucket.siteofquan-FE-s3.bucket}"
}
resource "aws_cloudfront_origin_access_identity" "S3_OAI" {

}
resource "aws_cloudfront_distribution" "FE_distribution" {
  origin {
    domain_name = aws_s3_bucket.siteofquan-FE-s3.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.S3_OAI.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.us_acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}