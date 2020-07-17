terraform {
  required_version = "~> 0.12"
  backend "s3" {
    bucket  = "memefier-remote-state-s3"
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "memefier-remote-state-s3"
  # Enable versioning so we can see the full revision history of our
  # state files
  acl = "private"
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
