# Phase 1 - Structure

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

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