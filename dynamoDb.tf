# Define a DynamoDB table
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
#   read_capacity  = 20
#   write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

# Define the attribute schema for the table
  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    # write_capacity     = 10
    # read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }
  # Add tags for identification
  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}