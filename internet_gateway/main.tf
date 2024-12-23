# main.tf

# Buscar a VPC existente pelo nome ou tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-vpc-${var.environment}"] # Nome padrão da VPC
  }

}

# Buscar IDs das subnets públicas associadas à VPC
data "aws_subnet" "public_subnets" {
 for_each = toset([
    "ez-fastfood-public-subnet1",
    "ez-fastfood-public-subnet2"
  ])

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Name"
    values = [each.value]
  }
}

# Buscar a route table pública associada à VPC
data "aws_route_table" "public_route_table" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

 filter {
    name   = "tag:Name"
    values = ["${var.project}-public-rt-${var.environment}"]
  }


}

# Criar o Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name        = "${var.project}-igw-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}

# Criar rota padrão para o Internet Gateway
resource "aws_route" "public_default_route" {
  route_table_id         = data.aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associar a Route Table com as Subnets Públicas
resource "aws_route_table_association" "public_subnet_association" {
  for_each = data.aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = data.aws_route_table.public_route_table.id
}