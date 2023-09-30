variable "gcp_project_id" {
  description = "The name of the GCP project where the db and Cloud SQL Proxy will be created"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region where the db and Cloud SQL Proxy will be created"
  type        = string
}

# APIs for the project
variable "apis" {
  description = "List of APIs that need to be enabled for the project"
  type        = list(string)
  default = [
    "cloudasset.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    # Before running terraform destroying, comment the container apis
    # otherwise, the GKE cluster would get terminated as well
    #"clouddns.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "iamcredentials.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "storage.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com",
    "redis.googleapis.com"
  ]
}

variable "gke_cluster_name" {
  description = "Name of the rancher server cluster"
  type        = string
  default     = "main"
}

variable "master_cidr" {
  description = "CIDR block for control plane master"
  type = string
  default = ""
}

variable "authorized_networks" {
  description = "List of authorized networks that are allowed to talk to the GKE Master"
  type = list(string)
  default = [] 
}

variable "ip_cidr" {
  description = "Cluster CIDR IPs for Nodes, Pods, and Services. Each CIDR is represeted as, e.g., 10.10.0.0/20"
  type = object({
    nodes    = string
    pods     = string
    services = string
    master   = string
  })
}

variable "vpc_network_name" {
  description = "The name of VPC network"
  type        = string
}


variable "vpc_flow_log_enable" {
  description = "VPC flow logs status"
  type        = bool
  default     = false
}