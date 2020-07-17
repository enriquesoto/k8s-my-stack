resource "kubernetes_namespace" "frontend" {
  metadata {
    annotations = {
      name = "frontend"
    }

    labels = {
      app = "frontend"
    }

    name = "frontend"
  }
}

resource "kubernetes_namespace" "backend" {
  metadata {
    annotations = {
      name = "backend"
    }

    labels = {
      app = "backend"
    }

    name = "backend"
  }
}
