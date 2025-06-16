# main.tf
# Provide a reference to your default VPC
resource "aws_default_vpc" "default_vpc" {
}

# Provide references to your default subnets
resource "aws_default_subnet" "default_subnet_a" {
  # Use your own region here but reference to subnet 1a
  availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "default_subnet_b" {
  # Use your own region here but reference to subnet 1b
  availability_zone = "us-east-1b"
}

variable "ecs_cluster_name" {
  default = "nginx-cluster"
}
variable "ecs_service_name" {
  default = "nginx-service"
}
variable "max_tasks" {
  type    = number
  default = 2
}