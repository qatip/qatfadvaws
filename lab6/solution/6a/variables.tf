variable "project_name" {
  type    = string
  default = "Landing-Zone"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "env" {
  type    = string
  default = "DEV"

  validation {
    condition     = length(trimspace(var.env)) > 0
    error_message = "env must not be empty."
  }
}

variable "region" {
  type    = string
  default = "us-west-2"

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "region must not be empty."
  }
}

#/*
variable "allow_groups" {
  type = map(list(string))
}

variable "security_group_rules" {
  type = map(object({
    type              = string
    protocol          = string
    destination_ports = list(string)
    source_cidrs      = optional(list(string), [])
    destination_cidrs = optional(list(string), [])
    allow_groups      = optional(list(string), [])
    description       = optional(string)
  }))
}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Map of subnet names to CIDR blocks."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block used by the VPC. Must be a valid /16 CIDR block."
}

variable "instances" {
  description = "Map of EC2 instances to create."
  type = map(object({
    instance_type = string
  }))
}
#*/

