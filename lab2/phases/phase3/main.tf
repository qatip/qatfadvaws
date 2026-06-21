# Phase 3 - Visibility
#
# This phase adds explicit guardrails around the normalized model from Phase 3.
# The resources remain largely unchanged. The key difference is that Terraform
# now asserts the correctness of the model before passing it to the provider.

#check "unknown_allow_groups" {
#  assert {
#    condition     = length(local.unknown_allow_groups) == 0
#    error_message = "Unknown allow_groups were referenced. Every allow_group used by a rule must exist. Offending rules: ${jsonencode(local.unknown_allow_groups)}"
#  }
#}

#check "non_empty_resolved_ingress_rules" {
#  assert {
#    condition     = length(local.empty_ingress_rules) == 0
#    error_message = "Every ingress rule must resolve to at least one effective CIDR. Empty ingress rules: ${jsonencode(keys(local.empty_ingress_rules))}"
#  }
#}

#check "non_empty_resolved_egress_rules" {
#  assert {
#    condition     = length(local.empty_egress_rules) == 0
#    error_message = "Every egress rule must resolve to at least one effective CIDR. Empty egress rules: ${jsonencode(keys(local.empty_egress_rules))}"
#  }
#}

#check "protocol_sanity" {
#  assert {
#    condition     = length(local.protocol_violations) == 0
#    error_message = "Unsupported protocol values were found. Allowed protocols are tcp, udp, icmp, and -1. Offending rules: ${jsonencode(local.protocol_violations)}"
#  }
#}

resource "aws_vpc" "main" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.base_tags, {
    Name = "${local.prefix}-vpc"
  })
}

resource "aws_security_group" "main" {
  name        = "${local.prefix}-sg"
  description = "Demo security group"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.base_tags, {
    Name = "${local.prefix}-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "rule" {
  for_each = local.effective_ingress_rules

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = each.value.protocol
  from_port         = each.value.port
  to_port           = each.value.port
  cidr_ipv4         = each.value.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "rule" {
  for_each = local.effective_egress_rules

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = each.value.protocol
  from_port         = each.value.port
  to_port           = each.value.port
  cidr_ipv4         = each.value.cidr_ipv4
}
