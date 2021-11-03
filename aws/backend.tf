terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "backend-bucket-name"
    key            = "terraform.tfstate"
    dynamodb_table = "backend-table-name"
    encrypt        = true
  }
}
