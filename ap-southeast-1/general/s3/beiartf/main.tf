
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

module "beiartf_s3" {
  source = "github.com/traveloka/terraform-aws-beiartf-s3"

  environment = "management"

  roles_ids = [
    "AROAJNIF36KKKUH3LUBOC:*", # role beiartf ci writer
    "AROAJZR75IFQBR2RADMG6:*", # role beiartf reader
    "AROAI2IEV4NMLKC7UPSO4:*", # role beiartf Admin
    "AROAJTJVOI3G5TVVM2M76:*", # role beiartf writer for data team
    "AROAIKBSFYLAN6UXFHTKS:*", # role beiartf bei
  ]
}
