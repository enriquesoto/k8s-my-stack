provider "digitalocean" {
  token = var.do_token
}

terraform {
  backend "s3" {
    bucket  = "memefier-remote-state-s3"
    key     = "prod/data-stores/terraform.tfstate"
    encrypt = true
  }
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket = local.prod_bucket_name
  # Enable versioning so we can see the full revision history of our
  # state files
  acl = "public-read"
  cors_rule {
    allowed_headers = ["Authorization"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${var.domain}"]
    max_age_seconds = 3000
  }
  tags = {
    environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.prod_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "publicpolicybucket",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource": "arn:aws:s3:::${local.prod_bucket_name}/*"
    },
    {
      "Sid": "PrivateWriting",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.arn_user_backend}"
      },
      "Action": "s3:*",
      "Resource": [
          "arn:aws:s3:::${local.prod_bucket_name}",
          "arn:aws:s3:::${local.prod_bucket_name}/*"
      ]
    }
  ]
}
POLICY
}

resource "digitalocean_database_cluster" "clusterdb" {
  name                 = "clusterdb"
  engine               = "pg"
  version              = var.pg_version
  size                 = var.size_db
  region               = var.region_do
  node_count           = 1
  private_network_uuid = data.digitalocean_vpc.do_prod_vpc.id
}


