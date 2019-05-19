// We're using AWS, and we need to be in us-east-1 for the certs from AWS Cert Manager 
// to work with AWS Cloudfront
provider "aws" {
  region = "us-east-1"
}

// Create domain name variable
variable "www_domain_name" {
  default = "www.eissfeldt.com"
}

// Create root domain variable
variable "root_domain_name" {
  default = "eissfeldt.com"
}

// Create bucket using the same domain name - FQDN
// Make the bucket publicly accessible with permissions using acl
// Edit bucket policy per http://amzn.to/2Fa04ul
resource "aws_s3_bucket" "www" {
  bucket = "${var.www_domain_name}"
  acl    = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.www_domain_name}/*"]
    }
  ]
}
POLICY


// look for index file and error file
  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}


// This will setup AWS Certificate in cert manager. 
// We're using DNS to validate, and we'll need to login to the AWS console
// to AWS Cert Manager and click on the certs to open them and add the entries to AWS S3. 
// Future Scott intends to autmoate this.
// Use wildcard with domain to ensure subdomain is valid
resource "aws_acm_certificate" "certificate" {
  domain_name       = "*.${var.root_domain_name}"
  validation_method = "DNS"
  subject_alternative_names = ["${var.root_domain_name}"]
}

// Create AWS CloudFront distribution
resource "aws_cloudfront_distribution" "www_distribution" {
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "${aws_s3_bucket.www.website_endpoint}"
    origin_id   = "${var.www_domain_name}"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id       = "${var.www_domain_name}"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = ["${var.www_domain_name}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.certificate.arn}"
    ssl_support_method  = "sni-only"
  }
}

// Use AWS to host our zone
resource "aws_route53_zone" "zone" {
  name = "${var.root_domain_name}"
}

// Point AWS Route 53 to our CloudFront distribution
resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name    = "${var.www_domain_name}"
  type    = "A"

  alias = {
    name                   = "${aws_cloudfront_distribution.www_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.www_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
