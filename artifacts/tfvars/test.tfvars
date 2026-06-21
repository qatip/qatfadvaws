project_name = "Landing-Zone"
env          = "TEST"
region       = "us-west-2"

# Global allow groups - intentionally messy:
# - duplicates
# - whitespace
# - inconsistent formatting

allow_groups = {
  internal_networks = [
    "10.0.0.0/24",
    "10.0.0.0/24",
    " 10.0.1.0/24 ",
    "10.0.2.0/24"
  ]

  partner_networks = [
    "172.16.1.0/24 ",
    " 172.16.2.0/24",
    "172.16.1.0/24"
  ]
}

security_group_rules = {
  allow_http_office = {
    type              = "INGRESS"
    protocol          = "TCP"
    destination_ports = ["80"]
    source_cidrs      = [" 10.0.10.0/24 "]
    allow_groups      = ["internal_networks"]
    description       = "allow_http_to_office"
  }

  Allow-HTTPS-Office = {
    type              = "INGRESS"
    protocol          = "Tcp"
    destination_ports = ["443"]
    source_cidrs      = ["10.0.10.0/24", "10.0.10.0/24"]
    allow_groups      = ["internal_networks", "partner_networks"]
    description       = "Allow-HTTPS-to-Office"
  }

  Allow-HTTPS-Partner = {
    type              = "EGRESS"
    protocol          = "Tcp"
    destination_ports = ["443"]
    destination_cidrs = ["172.16.0.50/32"]
    allow_groups      = ["partner_networks"]
    description       = "Allow-HTTPS-to-Partner"
  }
}

subnet_cidrs = {
  mgmt = " 10.51.3.0/24 "
  data = "10.51.2.0/24"
  app  = " 10.51.1.0/24"
}

vpc_cidr = "10.51.0.0/16"

# test.tfvars
instances = {
  web01 = {
    instance_type = "t3.micro"
  }
  web02 = {
    instance_type = "t3.micro"
  }
}
