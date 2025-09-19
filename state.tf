terraform {
  backend "s3" {
    bucket = "terraform-b87"
    region = "us-east-1"
    key = "tools/state"

  }
}