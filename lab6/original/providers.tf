terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "qatipint-tfstate-CHANGE-ME"
    key          = "default.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }

}

provider "aws" {
  region = var.region
}