# output "public_route_table_id" {
#   description = "ID da Route Table pública"
#   value       = var.public_route_table_id  # Estamos recebendo isso via variável
# }

output "internet_gateway_id" {
  description = "ID do Internet Gateway criado"
  value       = aws_internet_gateway.igw.id
}