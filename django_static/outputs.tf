# IAM user info
output "access_key" {
    value = aws_iam_access_key.django_user_key.id
}
output "secret_key" {
    value = aws_iam_access_key.django_user_key.secret
}

# S3 bucket
output "s3_bucket" {
    value = aws_s3_bucket.bucket.id
}

# Cloudfront Distribution
output "cloudfront" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
