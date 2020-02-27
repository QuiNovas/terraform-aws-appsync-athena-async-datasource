local {
  policy_arns = var.athena_s3_staging_arn != "" ? ["arn:aws:iam::aws:policy/AmazonAthenaFullAccess", var.athena_datasource_policy_arn,
  ] : ["arn:aws:iam::aws:policy/AmazonAthenaFullAccess", var.athena_datasource_policy_arn, aws_iam_policy.non_default_staging_dir_access.arn]
}