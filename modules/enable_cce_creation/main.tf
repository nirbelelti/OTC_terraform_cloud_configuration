resource "opentelekomcloud_identity_agency_v3" "enable_cce_auto_creation" {
  name                  = "${var.project}-cce-admin-${var.stage_name}"
  description           = "Auto-created by Terraform to enable CCE creation"
  delegated_domain_name = "op_svc_cce"

  project_role {
    project = var.project
    roles   = ["Tenant Administrator"]
  }
}