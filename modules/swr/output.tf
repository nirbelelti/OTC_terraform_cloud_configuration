output "swr_data" {
  value = {
    name = opentelekomcloud_swr_repository_v2.repo_1.name
    id = opentelekomcloud_swr_repository_v2.repo_1.id
    organization = opentelekomcloud_swr_repository_v2.repo_1.organization
    path = opentelekomcloud_swr_repository_v2.repo_1.path
  }
}

output "organization_name" {
  value = opentelekomcloud_swr_organization_v2.org_1.name
}