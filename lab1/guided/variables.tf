variable "aws_region" {
  type        = string
  description = "AWS region for deployment."
}

variable "project_name" {
  type        = string
  description = "Project name used in resource naming."
}

variable "environment" {
  type        = string
  description = "Environment name."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet."
}

#/*
#Phases 1-3
variable "security_groups" {
  type        = list(string)
  description = "Ordered list of security group role names."
}
#*/


/*
#Phase 4
variable "security_groups" {
  type = list(object({
    name        = string
    description = string
  }))
  description = "Ordered list of security group objects."
}
*/


/*
#Phases 5-6
variable "security_groups" {
  type = map(object({
    description = string
  }))
  description = "Map of security group definitions keyed by stable role name."
}
*/