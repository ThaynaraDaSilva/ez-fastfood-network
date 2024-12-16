variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "AWS region for resource deployment"
}

variable "public_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr_block               = string
    availability_zone_suffix = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnet configurations"
  type = map(object({
    cidr_block               = string
    availability_zone_suffix = string
  }))
}



