module "appsync_athena_async_resolver" {
  environment_variables = {
    AWS_ATHENA_REGION_NAME    = local.aws_athena_region_name
    AWS_ATHENA_S3_STAGING_DIR = var.athena_s3_staging_dir
    AWS_ATHENA_SCHEMA_NAME    = var.athena_schema_name
    MAX_CONCURRENT_QUERIES    = var.max_concurrent_queries
    POLL_INTERVAL             = var.poll_interval
  }

  dead_letter_arn = var.dead_letter_arn
  handler         = "function.handler"
  kms_key_arn     = var.kms_key_arn
  l3_object_key   = "quinovas/appsync-athena-async-resolver/appsync-athena-async-resolver-0.1.0.zip"
  memory_size     = var.memory_size
  name            = "${var.name_prefix}-appsync-athena-async-resolver"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    aws_iam_policy.non_default_staging_dir_access_async.arn,
    var.athena_datasource_policy_arn,
  ]
  runtime = "python3.7"
  source  = "QuiNovas/lambdalambdalambda/aws"
  timeout = var.timeout
  version = "3.0.1"
}

resource "aws_iam_policy" "non_default_staging_dir_access_async" {
  name   = "${var.name_prefix}-appsync-athena-async-resolver-staging-s3-access"
  policy = data.aws_iam_policy_document.non_default_staging_dir_access.json
}

module "appsync_async_lambda_datasource" {
  api_id                   = var.api_id
  invoke_lambda_policy_arn = module.appsync_athena_async_resolver.invoke_policy_arn
  lambda_function_arn      = module.appsync_athena_async_resolver.arn
  name                     = "${replace(var.name_prefix, "-", "_")}Athena"
  source                   = "QuiNovas/appsync-lambda-datasource/aws"
  version                  = "3.0.0"
}

