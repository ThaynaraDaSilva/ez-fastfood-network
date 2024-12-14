# main.tf

# Define variables for flexibility
variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "project" {
  default = "ez-fast-food"
}

variable "api_name" {
  default = "ez-fast-food-api"
}

# Define the Ngrok URL for the local backend
variable "ngrok_url" {
  description = "Ngrok URL exposing the local backend API"
  default     = "https://878a-177-190-77-61.ngrok-free.app" # Replace with your actual Ngrok URL
}

# Create the API Gateway
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.api_name}-${var.environment}"
  protocol_type = "HTTP"

  tags = {
    Name        = "${var.api_name}-${var.environment}-api"
    Environment = var.environment
    Project     = var.project
  }
}

# Create the default stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true

  tags = {
    Name        = "${var.api_name}-${var.environment}-stage"
    Environment = var.environment
    Project     = var.project
  }
}

# Create an integration for the API Gateway with the Ngrok URL
resource "aws_apigatewayv2_integration" "backend_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "${var.ngrok_url}/api" # Update this path as needed
  payload_format_version = "1.0"
  integration_method     = "ANY" # Specifies the HTTP method, or use "GET", "POST", etc.
}


# Define a catch-all route to forward requests to the backend
resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.backend_integration.id}"
}


# Output the API Gateway endpoint
output "api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}