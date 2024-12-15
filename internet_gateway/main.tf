# main.tf
# Criar o Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project}-igw-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}


# Criar rota padrão para o Internet Gateway
resource "aws_route" "public_default_route" {
  route_table_id         = var.public_route_table_id # Passe como variável
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associar a Route Table com as Subnets Públicas
resource "aws_route_table_association" "public_subnet_association" {
  for_each = var.public_subnet_ids

  subnet_id      = each.value
  route_table_id = var.public_route_table_id
}
