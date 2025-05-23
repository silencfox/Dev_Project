# Terraform - Repositorio ECR para NGINX

Este proyecto crea un repositorio ECR llamado `nginx-custom` y habilita escaneo automático de imágenes.

## Pasos

1. Inicializar Terraform

```bash
terraform init

terraform output ecr_repository_url

####

REGION="us-east-1"
REPO=$(terraform output -raw ecr_repository_url)

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPO

docker build -t nginx-custom ./docker
docker tag nginx-custom:latest $REPO:latest
docker push $REPO:latest
