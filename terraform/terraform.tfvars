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

