variable "api_id" {
  description = "The API ID for the GraphQL API for the DataSource."
  type        = string
}

variable "athena_datasource_policy_arn" {
  description = "The arn of the iam policy that needs to be attached to the resolver lambda. This policy must be having read permissions to underlying datasource, which can be s3/dynamo etc and also access to KMS key used to decrypt the datasource"
  type        = string
}

variable "athena_s3_staging_arn" {
  defualt     = ""
  description = "Non default (other than arn:aws:s3:::aws-athena-query-results-*) S3 bucket arn that Athena will store the query results in"
  type        = string
}


variable "database" {
  default     = "default"
  description = "The AWS Athena Database to query. May be overridden in the query request. Defaults to default"
  type        = string
}

variable "dead_letter_arn" {
  description = "The arn for the SNS topic that handles dead letters"
  type        = string
}

variable "kms_key_arn" {
  description = "The arn of the KMS key used to encrypt the environment variables"
  type        = string
}

variable "limit" {
  default     = 100
  description = "The maximum number of results to return during the results request. May be overridden in the results request. Defaults to 100."
  type        = string
}

variable "memory_size" {
  default     = 128
  description = "Memory size of the lambda resolver"
  type        = number
}

variable "name_prefix" {
  default     = ""
  description = "The prefix to place on all created resources"
  type        = string
}

variable "timeout" {
  default     = 30
  description = "Timeout of the lambda resolver"
  type        = number
}

variable "workgroup" {
  default     = "primary"
  description = "The AWS Athena Workgroup to use during queries. May be overridden in the query request. Defaults to primary"
  type        = string
}