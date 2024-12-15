region                 = "us-east-1"
vpc_name               = "ez-fastfood-vpc"
cidr_block             = "10.0.0.0/16"
environment            = "dev"
project                = "ez-fastfood"

public_subnets = {
  "subnet1" = {
    cidr_block               = "10.0.1.0/24"
    availability_zone_suffix = "e"
  },
  "subnet2" = {
    cidr_block               = "10.0.2.0/24"
    availability_zone_suffix = "a"
  }
}

private_subnets = {
  "subnet1" = {
    cidr_block               = "10.0.3.0/24"
    availability_zone_suffix = "b"
  }
}


allowed_ips = ["177.190.77.161/32"]  # Seu IP para acesso ao PostgreSQL

# Regras de ingress
ingress_rules = [
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["177.190.77.68/32"] # Substitua pelo seu IP
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Exemplo para HTTP
  }
]

# Regras de egress
egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]