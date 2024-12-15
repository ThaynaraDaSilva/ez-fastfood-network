variable "vpc_id" {
  description = "ID da VPC onde o Security Group será criado"
  type        = string
}

variable "ingress_rules" {
  description = "Lista de regras de entrada (ingress) para o Security Group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "Lista de regras de saída (egress) para o Security Group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "project" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex.: dev, staging, prod)"
  type        = string
}
