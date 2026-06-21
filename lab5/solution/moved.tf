#/*
moved {
  from = aws_route_table.main
  to   = module.network.aws_route_table.main
}

moved {
  from = aws_route_table_association.subnet["app"]
  to   = module.network.aws_route_table_association.subnet["app"]
}

moved {
  from = aws_route_table_association.subnet["data"]
  to   = module.network.aws_route_table_association.subnet["data"]
}

moved {
  from = aws_route_table_association.subnet["mgmt"]
  to   = module.network.aws_route_table_association.subnet["mgmt"]
}

moved {
  from = aws_security_group.main
  to   = module.network.aws_security_group.main
}

moved {
  from = aws_subnet.subnet["app"]
  to   = module.network.aws_subnet.subnet["app"]
}

moved {
  from = aws_subnet.subnet["data"]
  to   = module.network.aws_subnet.subnet["data"]
}

moved {
  from = aws_subnet.subnet["mgmt"]
  to   = module.network.aws_subnet.subnet["mgmt"]
}

moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.0.50/32"]
  to   = module.network.aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.0.50/32"]
}

moved {
  from = aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.1.0/24"]
  to   = module.network.aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.1.0/24"]
}

moved {
  from = aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.2.0/24"]
  to   = module.network.aws_vpc_security_group_egress_rule.rule["allow-https-partner|tcp|443|172.16.2.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.0.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.0.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.1.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.1.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.10.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.10.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.2.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-http-office|tcp|80|10.0.2.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.0.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.0.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.1.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.1.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.10.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.10.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.2.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|10.0.2.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|172.16.1.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|172.16.1.0/24"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|172.16.2.0/24"]
  to   = module.network.aws_vpc_security_group_ingress_rule.rule["allow-https-office|tcp|443|172.16.2.0/24"]
}
#./

#/*
moved {
  from = aws_instance.web["web01"]
  to   = module.compute.aws_instance.web["web01"]
}
#*/