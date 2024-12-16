variable "public_route_table_id" {
  description = "ID da Route Table pública criada no módulo VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas para associar a route table"
  type        = map(string)
}

variable "project" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex.: dev, staging, prod)"
  type        = string
}
