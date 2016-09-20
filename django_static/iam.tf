resource "aws_iam_user" "django_user" {
    name = "django-${var.app}-${var.env}"
}

resource "aws_iam_access_key" "django_user_key" {
    user = "${aws_iam_user.django_user.name}"
}

resource "aws_iam_user_policy" "django_user_rw" {
   name = "${aws_iam_user.django_user.name}-rw"
   user = "${aws_iam_user.django_user.name}"
   policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prefix}-${var.app}-static-${var.env}",
                "arn:aws:s3:::${var.prefix}-${var.app}-static-${var.env}/*"
            ]
        }
   ]
}
EOF
}
