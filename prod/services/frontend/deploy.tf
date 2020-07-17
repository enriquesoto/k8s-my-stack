data "aws_ecr_repository" "frontend" {
  name = "memefier/frontend"
}

resource "kubernetes_deployment" "frontend_deploy" {
  metadata {
    name = "frontend-deploy"
    labels = {
      app = "frontend"
    }
    namespace = data.kubernetes_namespace.frontend.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        image_pull_secrets {
          name = kubernetes_secret.docker_credentials_frontend.metadata.0.name
        }
        container {
          image             = data.aws_ecr_repository.frontend.repository_url
          name              = "frontend"
          image_pull_policy = "Always"
          port {
            container_port = 8080
          }
          resources {
            limits {
              cpu    = "256m"
              memory = "256Mi"
            }
            requests {
              cpu    = "256m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

