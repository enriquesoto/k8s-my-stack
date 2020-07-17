provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  load_config_file = false
  host             = digitalocean_kubernetes_cluster.bosscluster.endpoint
  token            = digitalocean_kubernetes_cluster.bosscluster.kube_config.0.token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.bosscluster.kube_config.0.cluster_ca_certificate
  )
}
