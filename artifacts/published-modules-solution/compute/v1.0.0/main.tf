resource "terraform_data" "module_version" {
  input = {
    module  = "compute"
    version = "1.0.0"
    change  = "compute module version 1.0.0. release"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "web" {
  for_each = local.normalized_instances

  ami           = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type

  credit_specification {
    cpu_credits = "standard"
  }

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = merge(local.mod_tags, {
    Name = "${var.prefix}-${each.key}"
  })

  lifecycle {
    ignore_changes = [tags]
  }

}
