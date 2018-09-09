
output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = "${module.beiartf_s3.s3_bucket_arn}"
}
