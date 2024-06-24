# Example Terraform variables file for demonstration purposes.

# Note: If this file contains sensitive information such as AWS access keys,
# database passwords, or any other credentials, DO NOT commit it to version
# control systems like Git. Always include this file in your .gitignore to
# maintain security.

# This file is provided as a template to help you understand the required
# variables. Ensure sensitive information is managed securely, such as using
# environment variables or secure storage solutions like AWS Secrets Manager
# or HashiCorp Vault.

region = "us-east-1"

table_name = "MyDataTable"

api_name = "MyAPIGateway"

lambda_functions = [
  {
    name    = "StoreDataFunction"
    handler = "store_data.lambda_handler"
    runtime = "python3.8"
  },
  {
    name    = "RetrieveDataFunction"
    handler = "retrieve_data.lambda_handler"
    runtime = "python3.8"
  }
]

