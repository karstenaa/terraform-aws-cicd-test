provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "default-terraform-state-cicd-ap-southeast-1-170466898939"
    key            = "ap-southeast-1/general/terraform-ci-cd/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "default-terraform-state-cicd-ap-southeast-1-170466898939"
  }
}

module "terraform_aws_codebuild" {
  source            = "github.com/traveloka/terraform-aws-codebuild-terraform-ci-cd.git?ref=v0.1.0"
  image             = "traveloka/codebuild-terraform-ci-cd-image:latest"
  terraform_version = "0.11.8"
  product_domain    = "bei"
  environment       = "staging"

  source_repository_url = "https://github.com/traveloka/terraform-aws-cicd-test.git"
}
