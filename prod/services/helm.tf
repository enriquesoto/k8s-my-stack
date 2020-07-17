provider "helm" {
  kubernetes {
    config_path = "${path.module}/${local_file.kubernetes_config.filename}"
    cluster_ca_certificate = base64decode(
        digitalocean_kubernetes_cluster.bosscluster.kube_config[0].cluster_ca_certificate
    )
  }
}


resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  set {
    name = "controller.config.proxy-body-size"
    value = "8m"
    type = "string"
  }
}