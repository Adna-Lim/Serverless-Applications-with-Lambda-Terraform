resource "aws_dynamodb_table" "my_data_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "payload"
    type = "S"
  }

  # Name of the global secondary index 
  global_secondary_index {
    name               = "PayloadIndex"
    hash_key           = "payload"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }

  tags = {
    Environment = "Production"
  }
}
