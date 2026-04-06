output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.demo.id
}

output "security_group_names" {
  value = [for sg in aws_security_group.demo : sg.name]
}

output "security_group_addresses" {
  value = [for i, sg in aws_security_group.demo : "aws_security_group.demo[${i}] => ${sg.name}"]
}
