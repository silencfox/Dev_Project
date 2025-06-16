# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "eks_name" {
  description = "nombre del cluster EKS"
  type        = string
  default     = "education-eks"
}
