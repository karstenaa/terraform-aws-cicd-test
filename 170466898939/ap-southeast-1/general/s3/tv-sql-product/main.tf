
provider "aws" {
  version = "1.13.0"
  region  = "ap-southeast-1"
}
terraform {
  backend "s3" {
    bucket         = "default-terraform-state-cicd-ap-southeast-1-170466898939"
    key            = "ap-southeast-1/general/s3/tv-sql-product/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "default-terraform-state-cicd-ap-southeast-1-170466898939"
  }
}
module "tv_sql_product_s3_bucket_name" {
  source = "github.com/traveloka/terraform-aws-resource-naming?ref=v0.4.0"

  name_prefix   = "${local.tv_sql_product_s3_bucket_name_prefix}"
  resource_type = "s3_bucket"
}

resource "aws_s3_bucket" "tv_sql_product" {
  bucket        = "${module.tv_sql_product_s3_bucket_name.name}"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name          = "${module.tv_sql_product_s3_bucket_name.name}"
    ProductDomain = "${local.product_domain}"
    Description   = "S3 bucket to store artifact from tv-sql-product repository"
    Environment   = "management"
  }
}

resource "aws_s3_bucket_policy" "tv_sql_product" {
  bucket = "${aws_s3_bucket.tv_sql_product.id}"
  policy = "${data.aws_iam_policy_document.tv_sql_product.json}"
}

module "beiartf_s3" {
  source = "github.com/traveloka/terraform-aws-beiartf-s3"

  environment = "management"

  roles_ids = [
    "AROAJNIF36KKKUH3LUBOC:*", # role beiartf ci writer
    "AROAJZR75IFQBR2RADMG6:*", # role beiartf reader
    "AROAI2IEV4NMLKC7UPSO4:*", # role beiartf Admin
    "AROAJTJVOI3G5TVVM2M76:*", # role beiartf writer for data team
    "AROAJP4N2XYTNEUJBPV34:*", # role beiartf midas
    "AROAIKBSFYLAN6UXFHTKS:*", # role beiartf bei
  ]
}
