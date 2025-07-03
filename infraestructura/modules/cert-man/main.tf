resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
    labels = {
      "name" = "cert-manager"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = kubernetes_namespace.cert_manager.metadata[0].name
  create_namespace = false 
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.18.2"

  set = [ {
      name  = "installCRDs"
      value = "true"
    },{
      name  = "prometheus.enabled"
      value = "false"    
    }
  ]

  recreate_pods     = true
  timeout           = 100
  wait              = true
  wait_for_jobs     = true
  atomic            = true
  cleanup_on_fail   = true

  depends_on = [kubernetes_namespace.cert_manager]
}

