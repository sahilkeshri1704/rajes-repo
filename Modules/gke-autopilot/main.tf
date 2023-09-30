resource "google_container_cluster" "gke" {
  provider    = google-beta
  name        = var.gke_cluster_name
  location    = var.location
  description = "GKE cluster created by terraform"

  network    = var.vpc_name
  subnetwork = var.subnet_name
  vertical_pod_autoscaling {
    enabled = true
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # Need Control plane's master public IP to access externally

    master_ipv4_cidr_block = var.master_ipv4_cidr_block # IP range for Cluster Master(control plane)
    master_global_access_config {
      enabled = true
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_source_ranges
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  # Enable autopilot for the cluster
  enable_autopilot = true

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.1.0.0/16" # CIDR Block for GKE pods
    services_ipv4_cidr_block = "10.2.2.0/24" # CIDR Block for GKE Services
  }


  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    istio_config {
      disabled = true
      #auth = "AUTH_MUTUAL_TLS"
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}
