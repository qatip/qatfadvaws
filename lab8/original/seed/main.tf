resource "aws_vpc" "legacy" {
  cidr_block = "10.50.0.0/16"

  tags = {
    Name = "legacy-vpc"
  }
}

resource "aws_subnet" "legacy" {
  vpc_id            = aws_vpc.legacy.id
  cidr_block        = "10.50.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "legacy-subnet"
  }
}

resource "aws_security_group" "legacy" {
  name        = "legacy-sg"
  description = "Legacy security group"
  vpc_id      = aws_vpc.legacy.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.50.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "legacy-sg"
  }
}

resource "aws_network_interface" "legacy" {
  subnet_id       = aws_subnet.legacy.id
  security_groups = [aws_security_group.legacy.id]

  tags = {
    Name = "legacy-eni"
  }
}