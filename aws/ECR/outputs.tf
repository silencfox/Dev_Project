output "ecr_repository_url" {
  value = aws_ecr_repository.nginx_repo.repository_url
}

output "ecr_repository_name" {
  value = aws_ecr_repository.nginx_repo.name
}
