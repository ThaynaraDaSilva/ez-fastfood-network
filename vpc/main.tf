# main.tf

# Buscar VPC existente com a tag Name específica
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-vpc-${var.environment}"]
  }
}

# Criar a VPC
resource "aws_vpc" "ez_fastfood_vpc" {
  count = length(data.aws_vpc.selected.id) == 0 ? 1 : 0 # condição para não criar recurso quando já existir.
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
  count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0
  
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
  count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0
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
  count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0

  vpc_id = aws_vpc.ez_fastfood_vpc.id

  tags = {
    Name        = "${var.project}-public-rt-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}

# Route Table Privada
resource "aws_route_table" "private" {
 count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0

  vpc_id = aws_vpc.ez_fastfood_vpc.id

  tags = {
    Name        = "${var.project}-private-rt-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}

# Associar a Route Table às Subnets Públicas
resource "aws_route_table_association" "public" {
  count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Associar a Route Table às Subnets Privadas
resource "aws_route_table_association" "private" {
  count = length(aws_vpc.ez_fastfood_vpc) > 0 ? 1 : 0
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}


