
resource opentelekomcloud_swr_organization_v2 org_1 {
  name = "${var.name}-${var.stage_name}-org"
}


resource opentelekomcloud_swr_repository_v2 repo_1 {
  organization = opentelekomcloud_swr_organization_v2.org_1.name
  name         = "${var.name}-${var.stage_name}-swr-repo"
  description  = var.description
  category     = "linux"
  is_public    = var.is_public
}