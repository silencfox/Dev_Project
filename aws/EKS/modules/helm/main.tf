
resource "helm_release" "cloudwatch_agent" {
  name       = "cloudwatch-agent"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-cloudwatch-metrics"
  namespace  = "amazon-cloudwatch"
  create_namespace = true
}


resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.14.2"

  set {
    name  = "installCRDs"
    value = "true"
  }


}


resource "helm_release" "node_exporter" {
  name             = "prometheus-node-exporter"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus-node-exporter"
  namespace        = "monitoring"
  create_namespace = true

}


resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-state-metrics"
  namespace        = "monitoring"
  create_namespace = true

}


resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "kube-system"

}


/*
resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  set {
    name  = "grafana.adminPassword"
    value = "admin" # Cambiar por una password segura
  }
  set {
    name  = "grafana.service.type"
    value = "LoadBalancer"
  }


}
*/

/*
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "$2a$12$jzAFpTbUDypkK3/N9YXHzOB3USAtUXqfDEPlV2Xq0xlfI2DBRMXYO" # password: admin
  }
#  set {
#    name  = "server.service.type"
#    value = "LoadBalancer"
#  }
#

}
*/

resource "helm_release" "jenkins" {
  name             = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  namespace        = "jenkins"
  create_namespace = true

  set {
    name  = "controller.admin.password"
    value = "admin" # Cambiar por algo más seguro
  }

  set {
    name  = "controller.serviceType"
    value = "LoadBalancer"
  }


}
