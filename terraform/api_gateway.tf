resource "aws_api_gateway_rest_api" "my_api" {
  name = var.api_name
}

# Define a resource in the API Gateway with the path '/data'
resource "aws_api_gateway_resource" "data" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "data"
}

# Define a sub-resource in the API Gateway with the path '/data/{id}'
resource "aws_api_gateway_resource" "data_id" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_resource.data.id
  path_part   = "{id}"
}

# Define a POST method for '/data' resource in API Gateway
resource "aws_api_gateway_method" "post_data" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.data.id
  http_method   = "POST"
  authorization = "NONE"
}

# Define a GET method for '/data/{id}' sub-resource in API Gateway
resource "aws_api_gateway_method" "get_data" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.data_id.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.id" = true
  }
}

# Define integrations between API Gateway methods and Lambda functions
resource "aws_api_gateway_integration" "post_data" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.data.id
  http_method             = aws_api_gateway_method.post_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.store_data_function.invoke_arn
}

resource "aws_api_gateway_integration" "get_data" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.data_id.id
  http_method             = aws_api_gateway_method.get_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.retrieve_data_function.invoke_arn

  request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
    }
}

# Define permissions for API Gateway to invoke Lambda functions
resource "aws_lambda_permission" "api_gateway_invoke_store" {
  statement_id  = "AllowAPIGatewayInvokeStore"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.store_data_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/POST/data"
}

resource "aws_lambda_permission" "api_gateway_invoke_retrieve" {
  statement_id  = "AllowAPIGatewayInvokeRetrieve"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.retrieve_data_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/GET/data/{id}"
}

# Deploy API Gateway to the 'prod' stage
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_method.post_data,
    aws_api_gateway_method.get_data,
    aws_api_gateway_integration.post_data,
    aws_api_gateway_integration.get_data,
    aws_lambda_permission.api_gateway_invoke_store,
    aws_lambda_permission.api_gateway_invoke_retrieve
  ]

  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
}