################################################################################
# PHASE 1 - STRUCTURE
#
# Purpose
# -------
# This phase separates transformation logic from resource creation.
#
# The original configuration performed all rule expansion directly inside the
# resource blocks, making the configuration difficult to understand and maintain.
#
# In this phase we introduce locals to build the rule model first, allowing the
# resources to simply consume the results.
#
# At this stage we DO NOT:
#   • clean the data
#   • remove duplicates
#   • standardize naming
#   • validate inputs
#
# The input remains intentionally chaotic.
#
# Think of this phase as moving logic into a pipeline without changing its
# behaviour.
################################################################################


locals {
  prefix = "${var.project_name}-${var.env}"

  base_tags = {
    App = var.project_name
    Env = var.env
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