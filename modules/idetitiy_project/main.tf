
resource "opentelekomcloud_identity_project_v3" "vpc_project" {
  name        = var.project_name  # Use the local variable for project name
  description = var.description
}
