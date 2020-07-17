terraform {
  backend "s3" {
    bucket  = "memefier-remote-state-s3"
    key     = "prod/services/backend/terraform.tfstate"
    encrypt = true
  }
}

