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


resource "aws_s3_bucket_versioning" "siteofquan-FE-s3_versioning" {
  bucket = aws_s3_bucket.siteofquan-FE-s3.id
  versioning_configuration {
    status = "Enabled"
  }
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

resource "aws_s3_object" "FE_index_file" {
  bucket       = aws_s3_bucket.siteofquan-FE-s3.bucket
  key          = "index.html"
  content      = "Hello world!"
  content_type = "text/html"

}

resource "aws_s3_object" "FE_error_file" {
  bucket       = aws_s3_bucket.siteofquan-FE-s3.bucket
  key          = "error.html"
  content      = "something's wrong!"
  content_type = "text/html"

}