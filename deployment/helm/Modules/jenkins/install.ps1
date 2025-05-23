helm repo add jenkins https://charts.jenkins.io
helm repo update

#helm uninstall jenkins -n jenkins
#kubectl delete namespace jenkins

helm install jenkins jenkins/jenkins -n jenkins -f values.yaml

kubectl get pods -n jenkins
kubectl exec --namespace jenkins -it svc/jenkins -- bash -c "cat /run/secrets/chart-admin-password && echo"

kubectl port-forward svc/jenkins 8080:8080 -n jenkins
