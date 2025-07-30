#
docker build -t silencfox/devsudemo:latest .
docker run -it --rm -p 8000:8000 --name devsuapp silencfox/devsudemo /bin/sh
docker push silencfox/devsudemo:latest

terraform destroy --auto-approve
terraform apply --auto-approve

kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.14.2 --set installCRDs=true
kubectl get crd | grep clusterissuer

helm lint devsudemo
helm template mdevsudemo

helm uninstall devsu-release -n devsu
helm install devsu-release ./devsudemo -n devsu --create-namespace #--set replicaCount=3
kubectl get all -n devsu


kubectl get certificate -n devsu
kubectl describe certificate -n devsu  devsudemo-ingress-tls-secret
kubectl get challenges -A
kubectl get clusterissuer -A
kubectl logs -l app=cert-manager -n cert-manager

kubectl describe certificaterequest -n devsu devsudemo-ingress-tls-secret-1
kubectl describe certificate -n devsu devsudemo-ingress-tls-secret
kubectl describe challenges -n devsu devsudemo-ingress-tls-secret-1-2138903330-155091912

kubectl exec -it devsudemo-7fb74dbf66-4zplv -n devsu -- bash

# Demo Devops NodeJs

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Node.js 18.15.0

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-nodejs.git
```

Install dependencies.

```bash
npm i
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `dev.sqlite`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
npm run test
```

To run locally the project you can use this command.

```bash
npm run start
```

Open http://localhost:8000/api/users with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "error": "error"
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "error": "User not found: <id>"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

## License

Copyright © 2023 Devsu. All rights reserved.
......
