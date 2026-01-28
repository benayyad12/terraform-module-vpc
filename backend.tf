terraform {
  backend "s3" {
    bucket       = "bucket-s3-backend-statetf-benayyad"
    key          = "global/s3/benayyad/terraform.tfstate"
    region       = "eu-west-3"
    use_lockfile = true
  }
}
