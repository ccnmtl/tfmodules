resource "aws_cloudfront_distribution" "cdn" {
    origin {
        domain_name = "${aws_s3_bucket.bucket.bucket}.s3.amazonaws.com"
        origin_id = "S3-${aws_s3_bucket.bucket.bucket}"
        s3_origin_config {}
    }
    default_root_object = "index.html"
    enabled = true

    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.bucket.bucket}"

        # Forward all query strings, cookies and headers
        forwarded_values {
            query_string = true

            cookies {
                forward = "all"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    price_class = "PriceClass_200"

    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}
