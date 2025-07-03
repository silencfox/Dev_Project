resource "helm_release" "devsu" {
  name       = "devsudemo"
  namespace  = "devsu"
  create_namespace = true
  chart      = "./devsudemo"

  #values = [
  #  file("./devsudemo/values.yaml")
  #]

  # Si usas set variables específicas:
  #set {
  #  name  = "replicaCount"
  #  value = "2"
  #}

}

resource "time_sleep" "wait_for_lb" {
  depends_on = [helm_release.devsu]

  create_duration = "3m" # o "1m" si deseas más tiempo
}

data "azurerm_dns_zone" "dns_zone" {
  name                = "kdvops.com"
  resource_group_name = "rg-dns-zone"
}

data "kubernetes_service" "svc_01" {
  metadata {
    name      = "devsudemo-svc1"
    namespace = "devsu"
  }
 depends_on = [time_sleep.wait_for_lb]
}

data "kubernetes_service" "svc_02" {
  metadata {
    name      = "devsudemo-svc2"
    namespace = "devsu"
  }
 depends_on = [time_sleep.wait_for_lb]
}

resource "azurerm_dns_a_record" "svc1_a_record" {
  name                = "svc1"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  records             = [data.kubernetes_service.svc_01.status[0].load_balancer[0].ingress[0].ip]

  depends_on = [data.kubernetes_service.svc_01]
}

resource "azurerm_dns_a_record" "svc2_a_record" {
  name                = "svc2"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  records             = [data.kubernetes_service.svc_02.status[0].load_balancer[0].ingress[0].ip]

  depends_on = [data.kubernetes_service.svc_02]
}
