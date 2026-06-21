# Phase 1 - Structure
#
# This phase improves structure, but not data quality.
# The input remains messy by design.
# We move repeated logic into locals, but we do not yet
# normalize, deduplicate, or validate the supplied data.



locals {
  prefix = "${var.project_name}-${var.env}"

  base_tags = {
    App = var.project_name
    ENV = var.env
  }

  raw_ingress_rules = {
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

  raw_egress_rules = {
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
}