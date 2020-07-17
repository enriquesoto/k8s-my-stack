variable "do_token" {}

variable "container_registry_backend" {}

variable "google_proyect_id" {}

variable "allowed_hosts" {}

variable "aws_access_key_id_backend_user" {}

variable "aws_secret_key_backend_user" {}

variable "google_api_key_backend_account" {}

variable "google_api_cloud_vision_backend_account" {}

variable "sendgrid_api_key" {}

variable "sentry_dsn" {}

variable "prod_bucket_subdomain" {}

variable "domain" {}

variable "cors_origin_whitelist_strings" {}

variable "facebook_app_secret" {}

variable "credential_volume_name" {
  default = "service-account-credentials-volume"
}

data "kubernetes_namespace" "backend" {
  metadata {
    name = "backend"
  }
}

locals {
  prod_bucket_name = "${var.prod_bucket_subdomain}.${var.domain}"
  backend_domain   = "api.${var.domain}"
}
