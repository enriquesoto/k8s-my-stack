resource "cloudflare_zone" "domain" {
  zone = var.domain
}

resource "cloudflare_record" "images" {
  zone_id = cloudflare_zone.domain.id
  name    = var.prod_bucket_subdomain
  value   = local.bucket_prod_cname_value
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.domain.id
  name    = "api"
  value   = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.domain.id
  name    = "www"
  value   = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "naked" {
  zone_id = cloudflare_zone.domain.id
  name    = "@"
  value   = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
  proxied = true
  type    = "A"
  ttl     = 1
}

# DIGITAL OCEAN

resource "digitalocean_domain" "root" {
  name = var.domain
}

resource "digitalocean_vpc" "do_prod_vpc" {
  name     = "do-prod-vpc"
  region   = "nyc1"
  ip_range = "10.116.0.0/24"
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = "kube-system"
  }
}

output "ip_nginx" {
  value = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
}

resource "digitalocean_record" "naked" {
  domain = digitalocean_domain.root.name
  type   = "A"
  name   = "@"
  ttl    = "3600"
  value  = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.root.name
  type   = "A"
  name   = "www"
  ttl    = "3600"
  value  = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
}

resource "digitalocean_record" "api" {
  domain = digitalocean_domain.root.name
  type   = "A"
  name   = "api"
  ttl    = "3600"
  value  = data.kubernetes_service.nginx_ingress.load_balancer_ingress.0.ip
}
