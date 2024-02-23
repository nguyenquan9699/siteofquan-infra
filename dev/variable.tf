variable "frontend_bucket_name" {
  type    = string
  default = "siteofquan-fe-bucket-dev"
}

variable "domain_name" {
  type    = string
  default = "dev.siteofquan.click"
}

variable "us_acm_certificate_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:566958912930:certificate/12a517b4-88f1-48be-a122-f2b393fa10ab"
}

variable "route53_ttl" {
  type    = number
  default = 300
}
