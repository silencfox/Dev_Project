
helm create alcachart
helm install --dry-run debug .
helm package alcachart/
helm repo index .
helm repo add silencfox https://github.com/silencfox/Dev_Project
helm search repo pelado
helm install --dry-run helm silencfox/alcachart
helm install helm silencfox/alcachart
helm uninstall helm
helm install helm silencfox/alcachart --set healthcheck.livenessProbe.path=/ --set healthcheck.readinessProbe.path=/

helm install nginx-v1 ./nginx-chart --set nameOverride=v1,ingress.host=nginx-v1.local,image.tag=1.0
helm install nginx-v2 ./nginx-chart --set nameOverride=v2,ingress.host=nginx-v2.local,image.tag=2.0



helm template testchart . --set nameOverride=v1,ingress.host=nginx-v1.local,image.tag=1.0 --create-namespace --namespace test
cls
helm delete testchart --namespace test
helm uninstall testchart --namespace test
helm install testchart . --set nameOverride=v1,ingress.host=nginx-v1.local,image.tag=1.0 --create-namespace --namespace test

minikube service testchart-svc -n test

#kubectl port-forward svc/testchart-svc -n test 8000:8080
