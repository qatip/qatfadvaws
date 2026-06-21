variable "region" {
  description = "AWS region used for the Terraform remote state backend."
  type        = string
  default     = "us-west-2"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name used to store Terraform state."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to backend resources."
  type        = map(string)
  default = {
    Course    = "QATIPINT"
    Lab       = "Lab04"
    ManagedBy = "Terraform"
    Purpose   = "RemoteStateBackend"
  }
}
