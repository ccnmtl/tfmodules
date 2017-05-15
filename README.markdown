## CTL Terraform Modules

Reusable [terraform](https://terraform.io/) modules for our
infrastructure.

### django_static

Static file configs for django apps.

* IAM User
* S3 bucket
* Cloudfront Distribution

S3 bucket is public-readable with CORS setup.
IAM user only has access to the S3 bucket and no other AWS resources.
Cloudfront distribution configured to use the S3 bucket as origin.

#### Example Usage

	module "django-example" {
	  source = "github.com/ccnmtl/tfmodules//django_static"
		app = "example"
		env = "prod"
	}

	output "django-example-access_key" {
		value = "${module.django-example.access_key}"
	}

	output "django-example-secret_key" {
		value = "${module.django-example.secret_key}"
	}

	output "django-example-bucket" {
		value = "${module.django-example.s3_bucket}"
	}

	output "django-example-cloudfront" {
		value = "${module.django-example.cloudfront}"
	}

Running `terraform apply` results in output like:

    django-example-access_key = AKIAI37SSEC5TED26RSQ
    django-example-secret_key = *******************
    django-example-bucket = ctl-tfexample-static-prod
    django-example-cloudfront = d3t6vzw86uqlhs.cloudfront.net


Which you can then use to configure your Django app and run `manage.py
collectstatic && manage.py compress`

#### Variables

* `app`
* `env`
* `prefix` - defaults to `ctl`

#### Outputs

* `access_key` + `secret_key` - credentials for the IAM user
* `s3_bucket` - name of the S3 bucket created
* `cloudfront` - cloudfront domain

### vault_storage

S3 storage for Vault

* IAM User
* S3 bucket

S3 bucket is restricted to just the IAM Vault user
IAM user only has access to the S3 bucket and no other AWS resources.

#### Example Usage

	module "vault-example" {
	  source = "github.com/ccnmtl/tfmodules//vault_storage"
		env = "prod"
	}

	output "vault-example-access_key" {
		value = "${module.vault-example.access_key}"
	}

	output "vault-example-secret_key" {
		value = "${module.vault-example.secret_key}"
	}

	output "vault-example-bucket" {
		value = "${module.vault-example.s3_bucket}"
	}

Running `terraform apply` results in output like:

    django-example-access_key = AKIA3I7SSEC5TED26RSQ
    django-example-secret_key = *******************
    django-example-bucket = ctl-vault-prod


Which you can then use to configure Vault.

#### Variables

* `env`
* `prefix` - defaults to `ctl`

#### Outputs

* `access_key` + `secret_key` - credentials for the IAM user
* `s3_bucket` - name of the S3 bucket created
