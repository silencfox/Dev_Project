resource "aws_eks_addon" "coredns" {
  cluster_name = var.cluster_name
  addon_name   = "coredns"
  #addon_version = "v1.11.1-eksbuild.4" # puedes omitir para usar la última compatible

  #resolve_conflicts = "OVERWRITE"

}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = var.cluster_name
  addon_name   = "kube-proxy"
  #addon_version = "v1.29.1-eksbuild.1" # ajusta según la versión de EKS

  #resolve_conflicts = "OVERWRITE"

}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
  #addon_version = "v1.15.2-eksbuild.1"

  #resolve_conflicts = "OVERWRITE"

}

resource "aws_eks_addon" "s3_csi_driver" {
  cluster_name     = var.cluster_name
  addon_name       = "aws-mountpoint-s3-csi-driver"
  #addon_version    = "v1.2.0-eksbuild.1" # Verifica la versión compatible
  #resolve_conflicts = "OVERWRITE"

}
