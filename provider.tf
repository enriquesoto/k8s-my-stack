# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "circleci" {
  api_token    = var.circle_ci_token
  vcs_type     = "github"
  organization = var.circle_ci_organizacion
}

# config loaded from env variables
provider "aws" {}

provider "cloudflare" {
  version   = "~> 2.0"
  email     = var.cloudflare_email
  api_token = var.cloudflare_api_token
}

provider "kubernetes" {
  load_config_file = false
  host             = data.digitalocean_kubernetes_cluster.bosscluster.endpoint
  token            = data.digitalocean_kubernetes_cluster.bosscluster.kube_config.0.token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.bosscluster.kube_config.0.cluster_ca_certificate
  )
}
