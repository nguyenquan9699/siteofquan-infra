resource "aws_lambda_function" "siteofquan-BE-lambda" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_exec.arn
  runtime       = var.lambda_runtime
  handler       = var.lambda_entry

  s3_bucket = aws_s3_bucket.siteofquan-BE-s3.id
  s3_key    = var.lambda_source_zip
  environment {
    variables = {

    }
  }
  depends_on = [aws_s3_bucket.siteofquan-BE-s3, aws_s3_object.siteofquan-BE-s3-object]
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.lambda_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${aws_iam_role.lambda_exec.name}-policy"
  role = aws_iam_role.lambda_exec.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:GetItem",
        "dynamodb:BatchGetItem"
      ]
      Resource = "arn:aws:dynamodb:*:*:table/${data.aws_dynamodb_table.siteofquan-BE-db.name}"
    }]
  })
}