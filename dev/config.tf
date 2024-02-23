terraform {
  cloud {
    organization = "siteofquan"

    workspaces {
      name = "siteofquan-dev"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      env = "dev"
      awsApplication = "arn:aws:resource-groups:ap-southeast-1:566958912930:group/siteofquan/0d7lh0ti9yel17gf98qtlpw2tw"
    }
  }
}