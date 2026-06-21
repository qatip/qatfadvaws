# Phase 1 - Structure
#
# The infrastructure is unchanged from Phase 1.
# The difference is that rule expansion now happens in locals,
# making the resource blocks easier to read.
#

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
  for_each = local.raw_ingress_rules

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = lower(each.value.protocol)
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  cidr_ipv4         = each.value.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "rule" {
  for_each = local.raw_egress_rules

  security_group_id = aws_security_group.main.id
  description       = each.value.description
  ip_protocol       = lower(each.value.protocol)
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  cidr_ipv4         = each.value.cidr_ipv4
}