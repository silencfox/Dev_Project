output "lb_ip_svc01" {
  value = data.kubernetes_service.svc_01.status[0].load_balancer[0].ingress[0].ip
  description = "IP pública del LoadBalancer creado por el chart Helm"
}

output "lb_ip_svc02" {
  value = data.kubernetes_service.svc_02.status[0].load_balancer[0].ingress[0].ip
  description = "IP pública del LoadBalancer creado por el chart Helm"
}
