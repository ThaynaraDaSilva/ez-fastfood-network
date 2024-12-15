# main.tf

# Criar a VPC
resource "aws_vpc" "ez_fastfood_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support   = true # adicionado devido ao BD estar exposto 
  enable_dns_hostnames = true # adicionado devido ao BD estar exposto 

  tags = {
    Name        = "${var.vpc_name}-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}
# Criar Subnets
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.ez_fastfood_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${var.region}${each.value.availability_zone_suffix}"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-public-${each.key}"
    Environment = var.environment
    Project     = var.project
  }
}

# Subnets Privadas
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.ez_fastfood_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${var.region}${each.value.availability_zone_suffix}"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project}-private-${each.key}"
    Environment = var.environment
    Project     = var.project
  }
}

# Route Table pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ez_fastfood_vpc.id

  tags = {
    Name        = "${var.project}-public-rt-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}

# Route Table Privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ez_fastfood_vpc.id

  tags = {
    Name        = "${var.project}-private-rt-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}

# Associar a Route Table às Subnets Públicas
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Associar a Route Table às Subnets Privadas
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}


