output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "ecs_service_name" {
  value = aws_ecs_service.nginx_service.name
}
