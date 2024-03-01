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


resource "aws_s3_bucket" "siteofquan-BE-s3" {
  bucket = var.backend_bucket_name

  tags = {
    Name = "BE bucket"
  }

}

resource "aws_s3_bucket_policy" "siteofquan-BE-s3_bucket_policy" {
  bucket = aws_s3_bucket.siteofquan-BE-s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.siteofquan-BE-s3.arn}/*"
      }
    ]
  })
}
data "http" "lambda_source_url" {
  url = var.lambda_init_source_url
}

data "archive_file" "archive_source" {
  type                    = "zip"
  source_content          = data.http.lambda_source_url.response_body
  source_content_filename = var.lambda_source
  output_path             = var.lambda_source_zip

  depends_on = [data.http.lambda_source_url]
}
resource "aws_s3_object" "siteofquan-BE-s3-object" {
  bucket = aws_s3_bucket.siteofquan-BE-s3.bucket
  key    = var.lambda_source_zip
  source = data.archive_file.archive_source.output_path
}