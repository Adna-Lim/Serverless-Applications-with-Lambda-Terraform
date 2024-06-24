# Define an IAM role for Lambda execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  # Define the trust relationship policy for assuming the role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "sts:AssumeRole"
      Effect   = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
  
  # Define an inline policy granting access to DynamoDB
  inline_policy {
    name   = "lambda-dynamodb-access"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.my_data_table.arn
      }]
    })
  }
}
