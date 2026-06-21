# Phase 0 - Chaos
#
# This phase is intentionally untidy.
# It uses raw tfvars input directly, performs no sanitisation,
# and expands one logical rule into multiple effective AWS rules
# using inline expressions.

resource "aws_vpc" "main" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.env}-vpc"
    App  = var.project_name
    ENV  = var.env
  }
}

resource "aws_security_group" "main" {
  name        = "${var.project_name}-${var.env}-sg"
  description = "Demo security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.env}-sg"
    App  = var.project_name
    ENV  = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "rule" {
  for_each = {
    for idx, item in flatten([
      for rule_key, rule in var.security_group_rules : [
        for port in rule.destination_ports : [
          for cidr in concat(
            try(rule.source_cidrs, []),
            flatten([
              for g in try(rule.allow_groups, []) :
              lookup(var.allow_groups, g, [])
            ])
          ) : {
            rule_key    = rule_key
            type        = rule.type
            protocol    = rule.protocol
            port        = port
            cidr_ipv4   = cidr
            description = try(rule.description, rule_key)
          }
        ]
      ]
    ]) : "${item.rule_key}|${item.port}|${idx}" => item
    if lower(item.type) == "ingress"
  }

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = lower(each.value.protocol)
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  cidr_ipv4         = each.value.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "rule" {
  for_each = {
    for idx, item in flatten([
      for rule_key, rule in var.security_group_rules : [
        for port in rule.destination_ports : [
          for cidr in concat(
            try(rule.destination_cidrs, []),
            flatten([
              for g in try(rule.allow_groups, []) :
              lookup(var.allow_groups, g, [])
            ])
          ) : {
            rule_key    = rule_key
            type        = rule.type
            protocol    = rule.protocol
            port        = port
            cidr_ipv4   = cidr
            description = try(rule.description, rule_key)
          }
        ]
      ]
    ]) : "${item.rule_key}|${item.port}|${idx}" => item
    if lower(item.type) == "egress"
  }

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = lower(each.value.protocol)
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  cidr_ipv4         = each.value.cidr_ipv4
}