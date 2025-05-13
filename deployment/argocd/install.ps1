kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

#helm uninstall argocd -n argocd
helm install argocd argo/argo-cd `
  --namespace argocd `
  --set server.service.type=NodePort `
  --set server.service.nodePort=32080 `
  --set server.service.httpNodePort=32080 `
  --set server.service.httpsNodePort=32443
  
##  ARGO ROLLOUTS
#helm uninstall argo-rollouts
helm install argo-rollouts argo/argo-rollouts --set dashboard.enabled=true
#helm install argo-rollouts argo/argo-rollouts `
#  --set dashboard.enabled=true `
#  --set dashboard.service.type=NodePort `
#  --set dashboard.service.nodePort=31080

#  kubectl port-forward service/argo-rollouts-dashboard 31000:3100

#kubectl create namespace argo-rollouts
#kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

## sh
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d echo

## pwsh
Start-Sleep 120
$secret = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
$password = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))
Write-Host "Contraseña de admin: $password"

#helm upgrade argocd argo/argo-cd -n argocd `
#  --set server.service.type=LoadBalancer

helm upgrade argocd argo/argo-cd -n argocd -f values.yaml

## INSTALA APP LUEGO DE 
kubectl apply -f app.yaml


##  helm uninstall argocd -n argocd

## solo en minikube
## Star redirect puerto 8080
kubectl port-forward svc/argocd-server -n argocd 8080:443
