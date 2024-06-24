# Output the name of the DynamoDB table
output "dynamodb_table_name" {
  value = aws_dynamodb_table.my_data_table.name
}

# Output the names of the Lambda functions
output "lambda_function_names" {
  value = [
    aws_lambda_function.store_data_function.function_name,
    aws_lambda_function.retrieve_data_function.function_name
  ]
}

# Output the invoke URL of the API Gateway deployment
output "api_gateway_url" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}
