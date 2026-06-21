output "bucket_name" {
  value = aws_s3_bucket.state.bucket
}

output "backend_config" {
  value = <<EOT

backend "s3" {
  bucket       = "${aws_s3_bucket.state.bucket}"
  key          = "business-unit-state.tfstate"
  region       = "${var.aws_region}"
  use_lockfile = true
}

EOT
}