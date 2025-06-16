# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks), containing
Terraform configuration files to provision an EKS cluster on AWS.

terraform destroy --auto-approve
terraform apply --auto-approve

aws eks update-kubeconfig --region "us-east-1" --name education-eks
kubectl get svc