# Define AWS Lambda function for storing data
resource "aws_lambda_function" "store_data_function" {
  filename      = "${path.module}/../store_data_function.zip"
  function_name = var.lambda_functions[0].name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.lambda_functions[0].handler
  runtime       = var.lambda_functions[0].runtime
}

# Define AWS Lambda function for retrieving data
resource "aws_lambda_function" "retrieve_data_function" {
  filename      = "${path.module}/../retrieve_data_function.zip"
  function_name = var.lambda_functions[1].name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.lambda_functions[1].handler
  runtime       = var.lambda_functions[1].runtime
}
