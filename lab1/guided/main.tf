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
# Phase 1-3
resource "aws_security_group" "demo" {
  count       = length(var.security_groups)
  name        = "${var.project_name}-${var.environment}-${var.security_groups[count.index]}"
  description = "Security group for ${var.security_groups[count.index]}"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-${var.security_groups[count.index]}"
    Role = var.security_groups[count.index]
  }
}
#*/


/*
#Phase 4
resource "aws_security_group" "demo" {
  count       = length(var.security_groups)
  name        = "${var.project_name}-${var.environment}-${var.security_groups[count.index].name}"
  description = var.security_groups[count.index].description
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-${var.security_groups[count.index].name}"
    Role = var.security_groups[count.index].name
  }
}
*/


/* 
#Phase 5-6
resource "aws_security_group" "demo" {
  for_each    = var.security_groups
  name        = "${var.project_name}-${var.environment}-${each.key}"
  description = each.value.description
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Role = each.key
  }
}
*/
