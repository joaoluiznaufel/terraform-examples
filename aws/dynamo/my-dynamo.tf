resource "aws_dynamodb_table" "my-dynamo-table" {
  name           = "my-dynamo-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "my-dynamo-table"
    Environment = "production"
  }

}