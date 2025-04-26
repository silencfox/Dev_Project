# 🚀 Dev_Project

¡Bienvenido a Dev_Project! 👋  
Este proyecto es un ejemplo práctico que combina **Docker**, **Terraform**, **Azure Pipelines** y **NGINX** para levantar una aplicación de manera eficiente y ordenada.

## Main
[![Build Status](https://dev.azure.com/the-punisher01/gitops/_apis/build/status%2Fsilencfox.Dev_Project?branchName=main)](https://dev.azure.com/the-punisher01/gitops/_build/latest?definitionId=46&branchName=main)

## Develop
[![Build Status](https://dev.azure.com/the-punisher01/gitops/_apis/build/status%2Fsilencfox.Dev_Project?branchName=develop)](https://dev.azure.com/the-punisher01/gitops/_build/latest?definitionId=46&branchName=develop)


## 📦 ¿Qué hay dentro?

- `app/` ➡️ Código de la aplicación Node.js 🍃
- `deployment/` ➡️ Archivos para desplegar la app.
- `infra/` ➡️ Scripts de infraestructura como código (IaC) usando Terraform.
- `nginx/` ➡️ Configuración de NGINX como proxy inverso "para reverse proxy (no en uso)".
- `pipeline/` ➡️ Definiciones para CI/CD.
- `tfstate/` ➡️ Archivos de estado remoto de Terraform.

## 🛠️ Tecnologías principales

- **Docker** 🐳
- **Terraform** ☁️
- **Azure DevOps Pipelines** 🔵
- **NGINX** 🌐
- **Node.js** ⚡

## 🚀 Cómo ejecutar el proyecto


## ⚡ ¿Cómo se dispara el despliegue después de hacer cambios en GitHub?

Cada vez que haces un **push** o creas un **pull request** en GitHub, se activa automáticamente un **pipeline de Azure DevOps**.

Este pipeline se encarga de:

1. Construir la aplicación si es necesario.
2. Aplicar cambios en la infraestructura usando Terraform.
3. Actualizar la configuración de NGINX si aplica.

Así garantizamos que todo cambio en el código o infraestructura se despliegue de forma controlada y automática 🚀.

---

## 🔧 Variables utilizadas en las plantillas de Terraform

Las plantillas de Terraform (`*.tf`) utilizan variables para parametrizar el despliegue. Estas son algunas de las principales:

- **Nombre de recursos:**
  - `resource_group_name`
  - `app_service_name`
  - `plan_name`

- **Región y configuración de Azure:**
  - `location`
  - `sku_tier`
  - `sku_size`

- **Detalles de red (opcional):**
  - `subnet_id`
  - `vnet_name`

- **Autenticación de Azure (variables de entorno necesarias):**
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`

**Nota:** Variables ARM* se colocan como variables secretas en azure pipeline antes de ejecutar Terraform.

- **Service connections de Azure **
  - `GitHub`
  - `SonarCloud`
  - `Azure Subscripcion`

```mermaid
flowchart TD
    A[Developer hace push o pull request a main en GitHub] --> B[Azure DevOps detecta el cambio]
    B --> C[Se ejecuta el Pipeline CI/CD]
    C --> D{¿Hay cambios en infraestructura?}
    D -- Sí --> E[Terraform aplica cambios en Azure]
    D -- No --> F[No se aplican cambios en Azure]
    E --> G[Continúa el despliegue de la app en AKS ☁️]
    F --> G
    G --> H[¿Pruebas Funcionales Exitosas 🚀?]
    H -- Sí --> I[Solicita aprobación para el próximo Stage]
    H -- No --> J[Ejecuta proceso de Rollback]
    I --> K[Aplicación desplegada y lista 🚀]

```


```bash


## 🔥 Flujo de trabajo de despliegue

```mermaid
flowchart TD
    A[Developer hace push o pull request a main en GitHub] --> B[Azure DevOps detecta el cambio]
    B --> C[Se ejecuta el Pipeline CI/CD]
    C --> D{¿Hay cambios en infraestructura?}
    D -- Sí --> E[Terraform aplica cambios en Azure]
    D -- No --> F[No se aplican cambios en Azure]
    E --> G[Continúa el despliegue de la app en AKS ☁️]
    F --> G
    G --> H[¿Pruebas Funcionales 🚀?]
    H -- Sí --> I[Solicita aprobacion para el proximo Stage (Dev, QA, PROD)]
    H -- No --> A[Ejecuta proceso Rollback]

    I --> J[Aplicación desplegada y lista 🚀]




## 📃 Licencia

Create By Kelvin D. Alcala 

Este proyecto está licenciado bajo la **GNU General Public License v3.0 (GPL-3.0)**.  
Esto significa que:

- Puedes usar, estudiar, compartir y modificar el proyecto libremente.
- Si distribuyes una versión modificada, debes hacerlo bajo la misma licencia GPL-3.0.
- Es necesario incluir una copia de esta licencia junto con el código.

Para más detalles completos, puedes leer la licencia aquí:  
👉 [Licencia GPL-3.0 completa](https://www.gnu.org/licenses/gpl-3.0.html)
