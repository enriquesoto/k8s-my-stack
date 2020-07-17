data "digitalocean_kubernetes_cluster" "bosscluster" {
  name = "bosscluster"
}

# BACKEND CONF

resource "aws_ecr_repository" "backend" {
  name                 = "memefier/backend"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

# FRONTEND CONF

resource "aws_ecr_repository" "frontend" {
  name                 = "memefier/frontend"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "aws_ecr_repository" {
  value = aws_ecr_repository.frontend
}

# FRONTEND AND BACKEND

resource "circleci_environment_variable" "aws_cr_backend" {
  project = var.circle_ci_projects[0]
  name    = "AWS_CR_URI"
  value   = aws_ecr_repository.backend.repository_url
}

resource "circleci_environment_variable" "aws_cr_frontend" {
  project = var.circle_ci_projects[1]
  name    = "AWS_CR_URI"
  value   = aws_ecr_repository.frontend.repository_url
}


resource "circleci_environment_variable" "kubeconfig" {
  project = var.circle_ci_projects["${count.index}"]
  name    = "KUBERNETES_KUBECONFIG"
  value   = base64encode(data.digitalocean_kubernetes_cluster.bosscluster.kube_config.0.raw_config)
  count   = 2
}

resource "circleci_environment_variable" "aws_cicduser_access_key_id" {
  project = var.circle_ci_projects["${count.index}"]
  name    = "AWS_ACCESS_KEY_ID"
  value   = file("${path.module}/config/cicd_user_aws_access_key_id")
  count   = 2
}

resource "circleci_environment_variable" "aws_cicduser_secret_key" {
  project = var.circle_ci_projects["${count.index}"]
  name    = "AWS_SECRET_ACCESS_KEY"
  value   = file("${path.module}/config/cicd_user_aws_secret_key")
  count   = 2
}

resource "circleci_environment_variable" "aws_cicduser_region" {
  project = var.circle_ci_projects["${count.index}"]
  name    = "AWS_DEFAULT_REGION"
  value   = var.region_aws
  count   = 2
}

