# main.tf

module "vpc" {
  source      = "./vpc"
  region      = var.region
  cidr_block  = var.cidr_block
  vpc_name    = var.vpc_name
  environment = var.environment
  project     = var.project
  public_subnets = var.public_subnets   # Passa a lista/objeto de subnets
  private_subnets = var.private_subnets
}

# Módulo Security Group
module "security_group" {
  source        = "./security_group"
  ingress_rules = var.ingress_rules    # Variáveis dinâmicas
  egress_rules  = var.egress_rules
  project       = var.project
  environment   = var.environment
  
}

# Módulo Internet Gateway
module "internet_gateway" {
  source            = "./internet_gateway"
  project           = var.project
  environment       = var.environment
}

# # Outputs
# output "public_route_table_id" {
#   description = "ID da Route Table pública"
#   value       = module.internet_gateway.public_route_table_id
# }

# output "rds_security_group_id" {
#   description = "ID do Security Group do RDS"
#   value       = module.security_group.rds_security_group_id
# }

# output "internet_gateway_id" {
#   description = "ID do Internet Gateway"
#   value       = module.internet_gateway.internet_gateway_id
# }


