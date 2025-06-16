helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring

helm install prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml

kubectl get pods -n monitoring
kubectl get svc -n monitoring

Start-Sleep 20
Start-Process powershell -ArgumentList 'kubectl port-forward svc/prometheus-stack-grafana 3000:80 -n monitoring'
##Windows serminal
##wt -w 0 nt --title "Port Forward Grafana" powershell -NoExit -Command "kubectl port-forward svc/prometheus-stack-grafana 3000:80 -n monitoring"


## Linux
##kubectl get secret prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 -d

##windows
$secret = kubectl get secret prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}"
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))

Start-Process chrome.exe "https://www.google.com"
