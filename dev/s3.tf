resource "aws_s3_bucket" "siteofquan-FE-s3" {
  bucket = var.frontend_bucket_name

  tags = {
    Name = "FE bucket"
  }

}

resource "aws_s3_bucket_policy" "siteofquan-FE-s3_bucket_policy" {
  bucket = aws_s3_bucket.siteofquan-FE-s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.S3_OAI.iam_arn
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.siteofquan-FE-s3.arn}/*"
      }
    ]
  })
}


resource "aws_s3_bucket_website_configuration" "siteofquan-FE-s3_staticweb" {
  bucket = aws_s3_bucket.siteofquan-FE-s3.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
