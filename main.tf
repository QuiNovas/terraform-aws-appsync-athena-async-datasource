module "appsync_athena_async_resolver" {
  environment_variables = {
    DATABASE  = var.database
    LIMIT     = var.limit
    WORKGROUP = var.workgroup
  }

  dead_letter_arn = var.dead_letter_arn
  handler         = "function.handler"
  kms_key_arn     = var.kms_key_arn
  l3_object_key   = "quinovas/appsync-athena-async-resolver/appsync-athena-async-resolver-0.1.0.zip"
  memory_size     = var.memory_size
  name            = "${var.name_prefix}-appsync-athena-async-resolver"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
  ]

  runtime = "python3.7"
  source  = "QuiNovas/lambdalambdalambda/aws"
  timeout = var.timeout
  version = "3.0.1"
}

module "appsync_async_lambda_datasource" {
  api_id                   = var.api_id
  invoke_lambda_policy_arn = module.appsync_athena_async_resolver.invoke_policy_arn
  lambda_function_arn      = module.appsync_athena_async_resolver.arn
  name                     = "${replace(var.name_prefix, "-", "_")}AthenaAsync"
  source                   = "QuiNovas/appsync-lambda-datasource/aws"
  version                  = "3.0.0"
}

