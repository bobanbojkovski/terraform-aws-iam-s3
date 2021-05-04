# S3 access policy
resource "aws_iam_user_policy_attachment" "test_policy_attach" {
  user       = module.iam_user.iam_user_name
  policy_arn = aws_iam_policy.test_policy.arn
}

resource "aws_iam_policy" "test_policy" {
  name   = "test_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.bucket_policy.json

  tags = {
    Name        = "test policy"
    Environment = "Dev"
  }

}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      module.s3_bucket.s3_bucket_arn,
    ]

    condition {
      test     = "StringNotLike"
      variable = "s3:prefix"

      values = [
        format("%s*", element(var.s3_bucket_objects, 2)) # stats

      ]
    }

  }

  statement {
    effect = "Deny"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket.s3_bucket_arn}/${element(var.s3_bucket_objects, 2)}*", # stats
      "${module.s3_bucket.s3_bucket_arn}/${element(var.s3_bucket_objects, 3)}*", # downloads
    ]

  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket.s3_bucket_arn}/*",
    ]

  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${module.s3_bucket.s3_bucket_arn}/${element(var.s3_bucket_objects, 1)}*", # uploads
    ]

  }

}
