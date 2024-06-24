variable "region" {
  description = "AWS region to deploy the resources"
}

variable "table_name" {
  description = "Name of the DynamoDB table"
}

variable "lambda_functions" {
  description = "Configuration for Lambda functions"
  type = list(object({
    name    = string
    handler = string
    runtime = string
  }))
}

variable "api_name" {
  description = "Name of the API Gateway"
}
