resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "DO-NOT-USE"
    ManagedBy = "Terraform"
    Purpose   = "Default SG - locked down"
  }
  ingress = []
  egress  = []
}



resource "aws_subnet" "demo" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.project_name}-${var.environment}-subnet-demo"
    Environment = var.environment
    Project     = var.project_name
  }
}


#/*
# Phases 1, 2 & 3
resource "aws_security_group" "demo" {
  count = length(var.security_groups)
  name  = "${var.project_name}-${var.environment}-secgp-${count.index}"
  #name = "${var.project_name}-${var.environment}-secgp-${var.security_groups[count.index]}"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Role = var.security_groups[count.index], Name = "${var.project_name}-${var.environment}-secgp-${var.security_groups[count.index]}" }
}
#*/

/* 
# Phase 4
resource "aws_security_group" "demo" {
  for_each = var.security_groups
  name     = "${var.project_name}-${var.environment}-secgp-${each.key}"
  #  name     = "secgp-${each.key}"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Role = each.value, Name = "${var.project_name}-${var.environment}-secgp-${each.key}" }
}
*/
