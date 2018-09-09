data "aws_iam_policy_document" "tv_sql_product" {
  statement {
    sid    = "AllowJenkinsToPut"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::517530806209:user/jenkins"]
    }

    resources = [
      "${aws_s3_bucket.tv_sql_product.arn}/*",
    ]
  }

  statement {
    sid    = "AllowTvlkDevToGet"
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::517530806209:root"]
    }

    resources = [
      "${aws_s3_bucket.tv_sql_product.arn}/*",
    ]
  }
}
