data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "web" {
  for_each = local.normalized_instances

  ami           = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = merge(local.mod_tags, {
    Name = "${var.prefix}-${each.key}"
  })
}
