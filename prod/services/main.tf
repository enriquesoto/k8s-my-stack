terraform {
  backend "s3" {
    bucket         = "memefier-remote-state-s3"
    key            = "prod/services/terraform.tfstate"
    encrypt        = true
  }
}

resource "digitalocean_kubernetes_cluster" "bosscluster" {
  name    = "bosscluster"
  region  = var.region_do
  version = var.k8s_version
  tags    = ["prod"]

  vpc_uuid = data.digitalocean_vpc.do_prod_vpc.id

  node_pool {
    name       = "boss-node"
    size       = var.size_node
    node_count = 1
  }
}


