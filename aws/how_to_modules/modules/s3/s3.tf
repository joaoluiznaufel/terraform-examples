resource "aws_s3_bucket" "my-bucket" {

  bucket   = "my-bucket"
  acl      = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name    = "my-bucket"
  }
}

output "my-bucket"   { value = aws_s3_bucket.my-bucket.bucket_domain_name }
