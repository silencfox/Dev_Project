helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/

helm install argocd argo/argo-cd `
  --namespace argocd `
  --set server.service.type=NodePort `
  --set server.service.nodePort=32080 `
  --set server.service.httpNodePort=32080 `
  --set server.service.httpsNodePort=32443

$secret = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
$password = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))
Write-Host "Contraseña de admin: $password"

helm install argo-rollouts argo/argo-rollouts `
  --set dashboard.enabled=true `
  --set dashboard.service.type=NodePort `
  --set dashboard.service.nodePort=31080