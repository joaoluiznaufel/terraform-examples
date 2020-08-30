locals {
  s3_origin_id = "my-origin-id"
}

resource "aws_cloudfront_distribution" "example-com" {
  origin {
    domain_name = "example.com"
    origin_id   = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront example"
  default_root_object = "index.html"

  # If there is a 403, return index.html with a HTTP 200 Response with a long TTL for the cache
  custom_error_response {
    error_caching_min_ttl = 0
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
  }

  aliases = ["*.example.com", "example.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      headers      = [
        "Accept-Encoding",
        "Origin",
      ]
      query_string = true

      cookies {
        forward = "none"
      }
    }

    # allow both http and https
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    # gzip compress
    compress               = true

  }

  #The price class for this distribution. One of:
  # PriceClass_All,
  # PriceClass_200,
  # PriceClass_100
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "example"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}