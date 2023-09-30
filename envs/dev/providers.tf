# Defines the Cloud resource provider that terraform can use
# Could include multiple providers if needed such as AWS

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region

}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_region

}