helm search hub grafana

helm repo add grafana https://grafana.github.io/helm-charts 
helm repo update

helm install grafana grafana/grafana

kubectl get service

kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext

minikube service grafana-ext

kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }po