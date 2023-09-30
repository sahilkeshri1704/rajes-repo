// vpc module

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.private_network.name
}

output "subnet_name" {
  description = "The name of the VPC subnet"
  value       = google_compute_subnetwork.private_subnetwork.name
}

output "link" {
  description = "A link to the VPC resource, useful for creating resources inside the VPC"
  value       = google_compute_network.private_network.self_link

}