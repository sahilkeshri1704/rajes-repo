#Enable APIs for the project
# Terraform may have cyclic depedency for few APIs which may need to be enabled through the Console UI

resource "google_project_service" "project" {
  for_each = toset(var.apis)
  project  = var.gcp_project_id
  service  = each.value
  disable_on_destroy = false
  disable_dependent_services = false
}