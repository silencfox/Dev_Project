#!/bin/bash

# Validar si se pasaron los parámetros necesarios
if [ $# -lt 5 ]; then
  echo "Uso: $0 <ruta_terraform> <ARM_CLIENT_ID> <ARM_CLIENT_SECRET> <ARM_TENANT_ID> <ARM_SUBSCRIPTION_ID>"
  exit 1
fi

##  ./script.sh /ruta/a/terraform  "tu_client_id" "tu_client_secret" "tu_tenant_id" "tu_subscription_id"

# Asignar los parámetros a variables
TF_DIR=$1
ARM_CLIENT_ID=$2
ARM_CLIENT_SECRET=$3
ARM_TENANT_ID=$4
ARM_SUBSCRIPTION_ID=$5

# Cambiar al directorio donde se ejecutarán los comandos Terraform
cd "$TF_DIR" || { echo "No se puede acceder al directorio $TF_DIR"; exit 1; }

# Autenticación con Azure
echo "Iniciando sesión en Azure..."
az login --service-principal -u "$ARM_CLIENT_ID" -p "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID" || { echo "Error al iniciar sesión en Azure"; exit 1; }
az account set --subscription "$ARM_SUBSCRIPTION_ID" || { echo "Error al seleccionar la suscripción"; exit 1; }

# Copiar el archivo terraform.tmptfvars a terraform.tfvars
cp terraform.tmptfvars terraform.tfvars

# Inicializar Terraform
echo "Iniciando Terraform..."
terraform init || { echo "Error al iniciar Terraform"; exit 1; }

# Refrescar el estado de Terraform
echo "Refrescando el estado de Terraform..."
terraform refresh || { echo "Error al refrescar el estado de Terraform"; exit 1; }

# Crear el plan de Terraform
echo "Generando el plan de Terraform..."
terraform plan -out="terraplan.tfplan" || { echo "Error al generar el plan de Terraform"; exit 1; }

# Ejecutar el plan de Terraform con reintentos
set +e

max_attempts=15
attempt=1

while [ $attempt -le $max_attempts ]; do
  echo "Intento $attempt: Aplicando Terraform plan..."

  terraform apply "terraplan.tfplan" > apply_output.txt 2>&1
  exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo "Terraform apply exitoso en el intento $attempt."
    break
  fi

  echo "Terraform apply falló. Analizando errores para importar recursos existentes..."

  # Buscar errores de recursos ya existentes
  grep "already exists" apply_output.txt > exists_errors.txt || true

  if [ ! -s exists_errors.txt ]; then
    echo "No se encontraron errores de 'already exists'. Error no recuperable."
    cat apply_output.txt
    exit 1
  fi

  # Procesar cada error
  while read -r line; do
    resource_id=$(echo "$line" | grep -oP "/subscriptions/[^\"]+")
    escaped_line=$(printf '%s\n' "$line" | sed 's/[]\/$*.^[]/\\&/g')
    resource_address=$(grep -B10 "$escaped_line" apply_output.txt | grep -oP 'module\.[^\s:]+' | head -n1)

    if [ ! -z "$resource_id" ] && [ ! -z "$resource_address" ]; then
      echo "Importando recurso $resource_address con ID $resource_id"
      terraform import "$resource_address" "$resource_id"
    else
      echo "No se pudo determinar resource address para el error detectado."
    fi
  done < exists_errors.txt

  echo "State actualizado. Regenerando terraform plan..."
  terraform plan -out terraplan.tfplan

  attempt=$((attempt + 1))
done

# Verificar si se alcanzó el máximo de intentos
if [ $attempt -gt $max_attempts ]; then
  echo "Error: Se alcanzó el máximo de intentos ($max_attempts) para aplicar Terraform. Abortando."
  exit 1
fi

echo "Terraform apply completado exitosamente."
