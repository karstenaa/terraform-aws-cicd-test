locals {
  product_domain = "bei"

  tv_sql_product_s3_bucket_name_prefix = "tv-sql-product-${local.product_domain}-southeast-1-170466898939"

  lambda_name = "inventoryavailabilityreport"

  source_path            = "source/main.js"
  source_compressed_path = "source/main.zip"
}
