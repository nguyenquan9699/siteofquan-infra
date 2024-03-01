variable "frontend_bucket_name" {
  type    = string
  default = "siteofquan-fe-bucket"
}

variable "backend_bucket_name" {
  type    = string
  default = "siteofquan-be-bucket-prod"
}

variable "domain_name" {
  type    = string
  default = "siteofquan.click"
}

variable "us_acm_certificate_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:566958912930:certificate/26508681-798e-490f-9531-5c514986aed7"
}

variable "route53_ttl" {
  type    = number
  default = 300
}

variable "dynamoDB_table" {
  type    = string
  default = "siteofquan"
}

variable "lambda_name" {
  type    = string
  default = "siteofquan-data-loader-prod"
}

variable "lambda_entry" {
  type    = string
  default = "lambda_function.lambda_handler"
}

variable "lambda_source" {
  type    = string
  default = "lambda_function.py"
}

variable "lambda_source_zip" {
  type    = string
  default = "lambda_function.zip"
}
variable "lambda_runtime" {
  type    = string
  default = "python3.10"
}

variable "lambda_init_source_url" {
  type    = string
  default = "https://raw.githubusercontent.com/nguyenquan9699/siteofquan-BE/main/lambda_function.py"
}