data "aws_dynamodb_table" "siteofquan-BE-db" {
  name = var.dynamoDB_table
}