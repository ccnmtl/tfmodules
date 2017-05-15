resource "aws_iam_user" "vault_user" {
    name = "vault-${var.env}"
}

resource "aws_iam_access_key" "vault_user_key" {
    user = "${aws_iam_user.vault_user.name}"
}

resource "aws_iam_user_policy" "vault_user_rw" {
    name = "${aws_iam_user.vault_user.name}-rw"
    user = "${aws_iam_user.vault_user.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prefix}-vault-${var.env}",
                "arn:aws:s3:::${var.prefix}-vault-${var.env}/*"
            ]
        }
   ]
}
EOF
}
