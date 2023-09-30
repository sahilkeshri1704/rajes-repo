# GCP Project 
gcp_project_id = "vizru-x-cloudwerx"
# GCP Region
gcp_region = "us-central1"

vpc_network_name    = "gke-vizru-private-vpc"
vpc_flow_log_enable = false

ip_cidr = {
  nodes    = "10.168.0.0/20"
  pods     = "10.10.0.0/16"
  services = "10.11.0.0/20"
  master   = "172.16.0.0/28"
}

authorized_networks = ["206.84.234.161/32", "103.42.194.23/32"]

gke_cluster_name   = "vizru-test"



