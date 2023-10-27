terraform {
  backend "s3" {
    bucket = "terraform-bucket112"
    key    = "backend/terraform-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-backend"
    shared_credentials_file = "~/.aws/credentials"
  }
}