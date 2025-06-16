# Terraform - Repositorio ECR para NGINX

Este proyecto crea un repositorio ECR llamado `nginx-custom` y habilita escaneo automático de imágenes.

## Pasos

1. Inicializar Terraform

```bash
terraform init

terraform output ecr_repository_url

####

$region = "us-east-1"
$repo = (terraform output -raw ecr_repository_url).Trim()

aws ecr get-login-password --region $region | docker login --username AWS --password-stdin 805400277785.dkr.ecr.us-east-1.amazonaws.com
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin 805400277785.dkr.ecr.$region.amazonaws.com

docker build -t nginx-custom ./docker
docker tag nginx-custom:latest $REPO:latest
docker push $REPO:latest
