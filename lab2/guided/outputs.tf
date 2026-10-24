# Phase 0 - Chaos

output "vpc_id" {
  value = aws_vpc.main.id
}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "ingress_rule_addresses" {
  value = keys(aws_vpc_security_group_ingress_rule.rule)
}

output "egress_rule_addresses" {
  value = keys(aws_vpc_security_group_egress_rule.rule)
}