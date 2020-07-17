variable "do_token" {}

variable "environment" {
  default = "production"
}

variable "domain" {}

variable "arn_user_backend" {}

variable "prod_bucket_subdomain" {}

variable "cloudflare_api_token" {}

variable "region_do" {}

variable "pg_version" {
  default = "12"
}

variable "size_db" {
  default = "db-s-1vcpu-1gb"
}

locals {
  prod_bucket_name = "${var.prod_bucket_subdomain}.${var.domain}"
}

data "digitalocean_vpc" "do_prod_vpc" {
  name = "do-prod-vpc"
}
