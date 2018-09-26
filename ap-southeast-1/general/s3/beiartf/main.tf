provider "aws" {
  version = "1.13.0"
  region  = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "default-terraform-state-cicd-ap-southeast-1-170466898939"
    key            = "ap-southeast-1/general/s3/beiartf/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "default-terraform-state-cicd-ap-southeast-1-170466898939"
  }
}
