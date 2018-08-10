terraform {
  backend "s3" {
    bucket         = "default-terraform-state-ap-southeast-1-170466898939"
    dynamodb_table = "default-terraform-state-ap-southeast-1-170466898939"
    key            = "ap-southeast-1/general/s3/tv-sql-product/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}

provider "aws" {
  version = "1.13.0"
  region  = "ap-southeast-1"
}

module "tv_sql_product_s3_bucket_name" {
  source = "https://github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.4.0"

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
