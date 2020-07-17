variable "do_token" {}

variable "region_aws" {}

variable "circle_ci_token" {}

variable "circle_ci_organizacion" {}

variable "circle_ci_backend_project" {}

variable "circle_ci_frontend_project" {}

variable "circle_ci_projects" {
  type = list(string)
}

variable "cloudflare_email" {}

variable "cloudflare_api_token" {}

variable "domain" {}

variable "prod_bucket_subdomain" {}

// locals

locals {
  bucket_prod_subdomain   = "${var.prod_bucket_subdomain}.${var.domain}"
  bucket_prod_cname_value = "${local.bucket_prod_subdomain}.s3.amazonaws.com"
}
