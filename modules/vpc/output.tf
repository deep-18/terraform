output "project_name" {
    value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

output "pri_sub_3a" {
  value = aws_subnet.pri_sub_3a.id
}