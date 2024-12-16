# main.tf

# Buscar a VPC existente pelo nome ou tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-vpc-${var.environment}"] # Nome padrão da VPC
  }
}

# Criar Security Group dinâmico
resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg-${var.environment}"
  description = "${var.project} rds sg"
  vpc_id      = data.aws_vpc.selected.id



  # Regras de ingress dinâmicas
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Regras de egress dinâmicas
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name        = "${var.project}-rds-sg-${var.environment}"
    Environment = var.environment
    Project     = var.project
  }
}