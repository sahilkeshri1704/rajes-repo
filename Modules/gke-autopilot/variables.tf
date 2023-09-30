variable "location" {
  description = "The default region for GKE cluster"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC for the cluster"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name for the cluster"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for control plane master"
  type        = string
}

variable "gke_cluster_name" {
  description = "Name of the rancher server cluster"
  type        = string
}

variable "master_authorized_source_ranges" {
  description = "Whitelist IP addresses that can communicate to GKE control plane"
  type        = list(string)
}
