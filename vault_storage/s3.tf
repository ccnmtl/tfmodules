resource "aws_s3_bucket" "bucket" {
    bucket = "${var.prefix}-vault-${var.env}"
    acl = "private"

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.vault_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prefix}-vault-${var.env}",
                "arn:aws:s3:::${var.prefix}-vault-${var.env}/*"
            ]
        }
    ]
}
EOF

    tags {
        Name = "Vault storage ${var.env}"
        Environment = "${var.env}"
        Terraform = "1"
    }
}
