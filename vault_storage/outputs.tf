# IAM user info
output "access_key" {
    value = aws_iam_access_key.vault_user_key.id
}
output "secret_key" {
    value = aws_iam_access_key.vault_user_key.secret
}

# S3 bucket
output "s3_bucket" {
    value = aws_s3_bucket.bucket.id
}
