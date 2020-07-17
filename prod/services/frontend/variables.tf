variable "container_registry_frontend" {}

variable "do_token" {}

variable "domain" {}

data "kubernetes_namespace" "frontend" {
  metadata {
    name = "frontend"
  }
}
