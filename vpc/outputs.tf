output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.ez_fastfood_vpc.id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas criadas"
  value       = { for k, subnet in aws_subnet.public_subnets : k => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas criadas"
  value       = { for k, subnet in aws_subnet.private_subnets : k => subnet.id }
}

output "public_route_table_id" {
  description = "ID da Route Table pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID da Route Table privada"
  value       = aws_route_table.private.id
}
