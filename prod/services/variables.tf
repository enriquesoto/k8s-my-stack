variable "region_do" {}

variable "do_token" {}

variable "k8s_version" {}

variable "size_node" {
  default = "s-2vcpu-4gb"
}

data "digitalocean_vpc" "do_prod_vpc" {
  name = "do-prod-vpc"
}
