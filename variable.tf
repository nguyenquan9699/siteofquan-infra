variable "frontend_bucket_name" {
  type    = string
  default = "siteofquan-fe-bucket"
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