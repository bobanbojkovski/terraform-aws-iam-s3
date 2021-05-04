provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket         = "<tfstate_bucket>"
    key            = "<dir>/<file.tfstate>"
    dynamodb_table = "<state_lock>"
    region         = "eu-west-1"
  }
}

# IAM user
module "iam_user" {
  source = "./modules/iam-user"

  name          = var.iam_user_name
  force_destroy = true

  pgp_key = "keybase:<user>"

  password_reset_required = false

  upload_iam_user_ssh_key = true

  ssh_public_key = "<ssh_public_key>"

  tags = {
    Name        = "dev user"
    Environment = "Dev"
  }

}


# S3 bucket
module "s3_bucket" {
  source = "./modules/s3/bucket"

  bucket = var.s3_bucket_bucket
  acl    = "private"

  versioning = {
    enabled = true
  }

  tags = {
    Name        = "dev bucket"
    Environment = "Dev"
  }

}

# S3 bucket objects
module "s3_object" {
  source   = "./modules/s3/object"
  for_each = toset(var.s3_bucket_objects)

  bucket = module.s3_bucket.s3_bucket_id
  key    = each.value

  tags = {
    Name        = "dev bucket object"
    Environment = "Dev"
  }

  depends_on = [
    module.s3_bucket,
  ]

}
