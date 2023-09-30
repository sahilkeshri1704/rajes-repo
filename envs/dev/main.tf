module "gke-auto" {
    source = "../../Modules/gke-autopilot"

    gke_cluster_name = var.gke_cluster_name
    location = var.gcp_region
    master_authorized_source_ranges = var.authorized_networks
    master_ipv4_cidr_block = var.master_cidr
    subnet_name = module.vpc.subnet_name
    vpc_name = var.vpc_network_name
  
}

module "vpc" {
  source = "../../Modules/vpc"

  name           = var.vpc_network_name
  gcp_region     = var.gcp_region
  ip_cidr_range  = var.ip_cidr
  vpc_flow_log_enable = var.vpc_flow_log_enable

}