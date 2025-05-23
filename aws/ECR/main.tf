provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "nginx_repo" {
  name                 = "nginx-custom"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "nginx-custom"
    Environment = "dev"
  }
}
