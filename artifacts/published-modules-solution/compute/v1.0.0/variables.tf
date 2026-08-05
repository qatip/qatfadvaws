variable "prefix" {}
variable "base_tags" {}
variable "subnet_id" {}
variable "security_group_id" {}

variable "instances" {
  description = "Map of EC2 instances to create."
  type = map(object({
    instance_type = string
  }))

  validation {
    condition = alltrue([
      for name, instance in var.instances :
      contains(["t3.micro", "t3.small"], instance.instance_type)
    ])
    error_message = "Instance types must be one of: t3.micro or t3.small."
  }

  validation {
    condition = length(var.instances) == length(toset([
      for name, instance in var.instances :
      lower(trimspace(name))
    ]))
    error_message = "Instance names must be unique after trimming and lowercasing."
  }
}