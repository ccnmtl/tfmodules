resource "aws_s3_bucket" "bucket" {
   bucket = "${var.prefix}-${var.app}-static-${var.env}"
	 acl = "public-read"

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.prefix}-${var.app}-static-${var.env}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.django_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prefix}-${var.app}-static-${var.env}",
                "arn:aws:s3:::${var.prefix}-${var.app}-static-${var.env}/*"
            ]
        }
    ]
}
EOF

   tags {
      Name = "Static files for ${var.app} ${var.env}"
			Environment = "${var.env}"
			Terraform = true
   }
}
