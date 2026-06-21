output "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform remote state."
  value       = aws_s3_bucket.tfstate.bucket
}

output "state_bucket_region" {
  description = "AWS region containing the Terraform state bucket."
  value       = var.region
}

output "backend_block_example" {
  description = "Example backend block to copy into the lab providers.tf file."
  value = <<EOT
backend "s3" {
  bucket       = "${aws_s3_bucket.tfstate.bucket}"
  key          = "default.tfstate"
  region       = "${var.region}"
  encrypt      = true
  use_lockfile = true
}
EOT
}
