# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "aws" {}

data "digitalocean_kubernetes_cluster" "bosscluster" {
  name = "bosscluster"
}

provider "kubernetes" {
  load_config_file = false
  host             = data.digitalocean_kubernetes_cluster.bosscluster.endpoint
  token            = data.digitalocean_kubernetes_cluster.bosscluster.kube_config.0.token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.bosscluster.kube_config.0.cluster_ca_certificate
  )
}
