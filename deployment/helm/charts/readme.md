
helm create alcachar
helm install --dry-run debug .
helm package alcachar/
helm repo index
helm repo add silencfox https://github.com/silencfox/Dev_Project
helm search repo pelado
helm install --dry-run helm silencfox/alcachar
helm install helm silencfox/alcachar
helm uninstall helm
helm install helm silencfox/alcachar --set healthcheck.livenessProbe.path=/ --set healthcheck.readinessProbe.path=/

