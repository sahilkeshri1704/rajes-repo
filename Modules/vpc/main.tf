// vpc module
terraform {
  required_providers {
    google-beta = {
      source  = "google-beta"
      version = "~> 4.79"
    }
    google ={
      source = "google"
      version = "~> 4.79"
    }
  }
  required_version = ">= 1.5" 
}

resource "google_compute_network" "private_network" {
  name                    = var.name
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "private_subnetwork" {
  name                     = "cluster-subnet-${var.name}"
  description              = "Subnet for GKE Pods and Services"
  ip_cidr_range            = var.ip_cidr_range.nodes
  region                   = var.gcp_region
  network                  = google_compute_network.private_network.id
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.ip_cidr_range.pods
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.ip_cidr_range.services
  }
  dynamic "log_config" {
    for_each = var.vpc_flow_log_enable == true ? [1] : []
    content {
      flow_sampling = 1.0
      metadata      = "INCLUDE_ALL_METADATA"
    }
  }

}

# We need to allocate an IP block for private IPs. We want everything in the VPC
# to have a private IP. This improves security and latency, since requests to
# private IPs are routed through Google's network, not the Internet.
resource "google_compute_global_address" "private_ip_block" {

  name         = "private-ip-block-${var.name}"
  description  = "A block of private IP addresses that are accessible only from within the VPC."
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  # We don't specify a address range because Google will automatically assign one for us.
  prefix_length = 20 # ~4k IPs
  network       = google_compute_network.private_network.self_link
}

# This enables private services access. This makes it possible for instances
# within the VPC and Google services to communicate exclusively using internal
# IP addresses

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}

## Since we have created Private Subnet, We need NAT for resource in this
## private subnet to reach to the internet
resource "google_compute_router" "router" {

  name    = "vpc-router-${var.name}"
  region  = google_compute_subnetwork.private_subnetwork.region
  network = google_compute_network.private_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "vpc-router-nat-${var.name}"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
