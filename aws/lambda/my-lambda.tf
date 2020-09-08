data "archive_file" "lambda_zip" {
  type          = "zip"
  source_file   = "${path.module}/files/index.py"
  output_path   = "${path.module}/output-files/hello.zip"
}

resource "aws_lambda_function" "my_lambda_lambda" {
  filename         = "${path.module}/output-files/hello.zip"
  function_name    = "hello-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
  timeout          = 30

}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}