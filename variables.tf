variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "project" {
  description = "Project name for tagging"
  type        = string
  default     = "ez-fastfood"
}


variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "environment" {
  default = "dev"
}


variable "vpc_name" {
  default = "ez-fastfood-dev-vpc"
}

variable "public_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr_block               = string
    availability_zone_suffix = string
  }))
}

variable "private_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr_block               = string
    availability_zone_suffix = string
  }))
}

# IPs Permitidos para o PostgreSQL (Security Group)
# variable "allowed_ips" {
#   description = "Liberação de IP para acesso a instancia"
#   type        = list(string)
#   default     = ["177.190.77.161/32"] # Substitua pelo seu IP
# }

variable "ingress_rules" {
  description = "Regras dinâmicas de ingress para o Security Group"
  type = list(object({
    description     = optional(string)
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = []
}

variable "egress_rules" {
  description = "Regras dinâmicas de egress para o Security Group"
  type = list(object({
    description = optional(string)
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}


