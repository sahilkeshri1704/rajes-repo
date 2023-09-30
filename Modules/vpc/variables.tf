variable "name" {
  description = "The name of the VPC to create"
  type        = string
}

variable "gcp_region" {
  description = "The default region for VPC connector"
  type        = string
}


variable "ip_cidr_range" {
  description = "Cluster CIDR IPs for Nodes, Pods, and Services. Each CIDR is represeted as, e.g., 10.10.0.0/20"
  type = object({
    nodes    = string
    pods     = string
    services = string
    master   = string
  })
}

variable "vpc_flow_log_enable" {
  description = "VPC flow logs status"
  type        = bool
}