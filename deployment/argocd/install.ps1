kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd -n argocd

## sh
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d echo

## pwsh
Start-Sleep 120
$secret = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
$password = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))
Write-Host "Contraseña de admin: $password"

## solo en minikube
kubectl port-forward svc/argocd-server -n argocd 8080:443

#helm upgrade argocd argo/argo-cd -n argocd `
#  --set server.service.type=LoadBalancer

helm upgrade argocd argo/argo-cd -n argocd -f values.yaml

## INSTALA APP LUEGO DE 
helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace -f values_app.yaml


###
##  helm uninstall argocd -n argocd
